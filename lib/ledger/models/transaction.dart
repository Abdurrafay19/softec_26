import 'package:hive/hive.dart';

// part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final bool isMoneyIn; // true for "In", false for "Out"

  @HiveField(3)
  final String name;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final DateTime date;

  @HiveField(6)
  final String category;

  Transaction({
    required this.id,
    required this.amount,
    required this.isMoneyIn,
    required this.name,
    required this.description,
    required this.date,
    required this.category,
  });
}
