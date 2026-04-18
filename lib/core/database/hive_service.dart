import 'package:hive_flutter/hive_flutter.dart';
import '../../ledger/models/transaction.dart';

class HiveService {
  static const String _boxName = 'transactions_box';

  // Initialize Hive and Register Adapter
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TransactionAdapter());
    await Hive.openBox<Transaction>(_boxName);
  }

  // Get the box
  static Box<Transaction> getTransactionBox() => Hive.box<Transaction>(_boxName);

  // Add Transaction
  static Future<void> addTransaction(Transaction transaction) async {
    final box = getTransactionBox();
    await box.add(transaction);
  }

  // Get All Transactions (Ordered by date)
  static List<Transaction> getAllTransactions() {
    final box = getTransactionBox();
    final list = box.values.toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }
}