import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/database/hive_service.dart';
import 'models/transaction.dart';

// 1. We create a "Summary" class to hold all calculated metrics
// This is better practice as it allows widgets to watch only what they need
class TransactionSummary {
  final List<Transaction> transactions;
  final double totalBalance;
  final double totalInflow;
  final double totalOutflow;
  final double netCash;

  TransactionSummary({
    required this.transactions,
    required this.totalBalance,
    required this.totalInflow,
    required this.totalOutflow,
    required this.netCash,
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
  )) {
    _loadTransactions();
  }

  void _loadTransactions() {
    final list = HiveService.getAllTransactions();
    
    double inflow = 0;
    double outflow = 0;

    for (var tx in list) {
      if (tx.isMoneyIn) {
        inflow += tx.amount;
      } else {
        outflow += tx.amount;
      }
    }

    state = TransactionSummary(
      transactions: list,
      totalBalance: inflow - outflow,
      totalInflow: inflow,
      totalOutflow: outflow,
      netCash: inflow - outflow,
    );
  }

  Future<void> addTransaction(Transaction transaction) async {
    await HiveService.addTransaction(transaction);
    _loadTransactions();
  }
}
