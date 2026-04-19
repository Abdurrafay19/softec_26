import 'package:hive/hive.dart';

part 'goal.g.dart';

@HiveType(typeId: 1)
class Goal extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double targetAmount;

  @HiveField(3)
  final DateTime? dueDate;

  @HiveField(4)
  final double currentAmount;

  Goal({
    required this.id,
    required this.name,
    required this.targetAmount,
    this.dueDate,
    this.currentAmount = 0,
  });

  Goal copyWith({
    String? name,
    double? targetAmount,
    DateTime? dueDate,
    double? currentAmount,
  }) {
    return Goal(
      id: id,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      dueDate: dueDate ?? this.dueDate,
      currentAmount: currentAmount ?? this.currentAmount,
    );
  }
}
