import 'package:hive/hive.dart';

part 'transaction.g.dart'; // This will be generated

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final bool isMoneyIn;

  @HiveField(3)
  final bool isPaid;

  @HiveField(4)
  final String vendorName;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final DateTime date;

  @HiveField(7)
  final String category; // e.g., "Pending Receivable", "Income", etc.

  Transaction({
    required this.id,
    required this.amount,
    required this.isMoneyIn,
    required this.isPaid,
    required this.vendorName,
    required this.description,
    required this.date,
    required this.category,
  });
}