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
  )) {
    _loadTransactions();
  }

  void _loadTransactions() {
    final list = HiveService.getAllTransactions();
    final now = DateTime.now();
    
    double inflow = 0;
    double outflow = 0;
    
    double mInflow = 0;
    double mOutflow = 0;

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
    }

    // Burn rate calculation (total monthly outflow / days passed in month)
    final daysPassed = now.day;
    final burnRate = daysPassed > 0 ? mOutflow / daysPassed : 0.0;

    state = TransactionSummary(
      transactions: list,
      totalBalance: inflow - outflow,
      totalInflow: inflow,
      totalOutflow: outflow,
      netCash: inflow - outflow,
      monthlyInflow: mInflow,
      monthlyOutflow: mOutflow,
      monthlyNetCash: mInflow - mOutflow,
      monthlyBurnRate: burnRate,
    );
  }

  Future<void> addTransaction(Transaction transaction) async {
    await HiveService.addTransaction(transaction);
    _loadTransactions();
  }
}
