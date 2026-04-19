import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/database/hive_service.dart';
import 'models/transaction.dart';

class TransactionSummary {
  final List<Transaction> transactions;
  final double totalBalance;
  
  // Lifetime stats
  final double totalInflow;
  final double totalOutflow;
  final double netCash;

  // Monthly stats (Current month)
  final double monthlyInflow;
  final double monthlyOutflow;
  final double monthlyNetCash;
  final double monthlyBurnRate;

  // Comparison stats
  final double previousMonthBalance;
  final double percentChange;

  TransactionSummary({
    required this.transactions,
    required this.totalBalance,
    required this.totalInflow,
    required this.totalOutflow,
    required this.netCash,
    required this.monthlyInflow,
    required this.monthlyOutflow,
    required this.monthlyNetCash,
    required this.monthlyBurnRate,
    required this.previousMonthBalance,
    required this.percentChange,
  });
}

final transactionsProvider = StateNotifierProvider<TransactionNotifier, TransactionSummary>((ref) {
  return TransactionNotifier();
});

class TransactionNotifier extends StateNotifier<TransactionSummary> {
  TransactionNotifier() : super(TransactionSummary(
    transactions: [],
    totalBalance: 0,
    totalInflow: 0,
    totalOutflow: 0,
    netCash: 0,
    monthlyInflow: 0,
    monthlyOutflow: 0,
    monthlyNetCash: 0,
    monthlyBurnRate: 0,
    previousMonthBalance: 0,
    percentChange: 0,
  )) {
    _loadTransactions();
  }

  void _loadTransactions() {
    final list = HiveService.getAllTransactions();
    final now = DateTime.now();
    final startOfCurrentMonth = DateTime(now.year, now.month, 1);
    
    double inflow = 0;
    double outflow = 0;
    
    double mInflow = 0;
    double mOutflow = 0;

    double prevMonthInflow = 0;
    double prevMonthOutflow = 0;

    for (var tx in list) {
      // Lifetime calculation
      if (tx.isMoneyIn) {
        inflow += tx.amount;
      } else {
        outflow += tx.amount;
      }

      // Monthly calculation (Check if same month and year)
      if (tx.date.month == now.month && tx.date.year == now.year) {
        if (tx.isMoneyIn) {
          mInflow += tx.amount;
        } else {
          mOutflow += tx.amount;
        }
      }

      // Previous Month Balance calculation (all transactions before current month)
      if (tx.date.isBefore(startOfCurrentMonth)) {
        if (tx.isMoneyIn) {
          prevMonthInflow += tx.amount;
        } else {
          prevMonthOutflow += tx.amount;
        }
      }
    }

    final currentTotalBalance = inflow - outflow;
    final previousMonthTotalBalance = prevMonthInflow - prevMonthOutflow;

    double change = 0;
    if (previousMonthTotalBalance != 0) {
      change = ((currentTotalBalance - previousMonthTotalBalance) / previousMonthTotalBalance.abs()) * 100;
    } else if (currentTotalBalance != 0) {
      // If previous balance was 0 and current is not, it's a 100% increase (or decrease if negative)
      change = currentTotalBalance > 0 ? 100.0 : -100.0;
    }

    // Burn rate calculation (total monthly outflow / days passed in month)
    final daysPassed = now.day;
    final burnRate = daysPassed > 0 ? mOutflow / daysPassed : 0.0;

    state = TransactionSummary(
      transactions: list,
      totalBalance: currentTotalBalance,
      totalInflow: inflow,
      totalOutflow: outflow,
      netCash: currentTotalBalance,
      monthlyInflow: mInflow,
      monthlyOutflow: mOutflow,
      monthlyNetCash: mInflow - mOutflow,
      monthlyBurnRate: burnRate,
      previousMonthBalance: previousMonthTotalBalance,
      percentChange: change,
    );
  }

  Future<void> addTransaction(Transaction transaction) async {
    await HiveService.addTransaction(transaction);
    _loadTransactions();
  }
}
