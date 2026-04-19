import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../core/database/hive_service.dart';
import '../../ledger/transaction_provider.dart';
import '../../shared/widgets/wavy_progress_bar.dart';
import '../models/goal.dart';
import 'add_edit_goal_screen.dart';

class ManageGoalsScreen extends ConsumerWidget {
  const ManageGoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentBalance = ref.watch(
      transactionsProvider.select((s) => s.totalBalance),
    );

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Manage Goals',
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: HiveService.goalsListenable(),
        builder: (context, box, _) {
          final goals = box.values.toList();

          if (goals.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.flag_outlined,
                    size: 64,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No goals yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: goals.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final goal = goals[index];
              return _GoalListTile(goal: goal, currentBalance: currentBalance);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditGoalScreen()),
          );
        },
        label: const Text('Add Goal'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class _GoalListTile extends StatelessWidget {
  final Goal goal;
  final double currentBalance;

  const _GoalListTile({required this.goal, required this.currentBalance});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currencyFormat = NumberFormat.currency(symbol: r'$');

    final isCompleted = currentBalance >= goal.targetAmount;
    final isPastDue =
        goal.dueDate != null &&
        goal.dueDate!.isBefore(DateTime.now()) &&
        !isCompleted;
    final progress = (currentBalance / goal.targetAmount).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted
              ? Colors.green.withValues(alpha: 0.5)
              : (isPastDue
                    ? Colors.red.withValues(alpha: 0.5)
                    : colorScheme.outlineVariant.withValues(alpha: 0.5)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Target: ${currencyFormat.format(goal.targetAmount)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (goal.dueDate != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        isPastDue
                            ? 'Passed Due'
                            : 'Due: ${DateFormat.yMMMd().format(goal.dueDate!)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isPastDue ? Colors.red : colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (!isCompleted && !isPastDue)
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditGoalScreen(goal: goal),
                      ),
                    );
                  },
                ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _showDeleteDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: WavyProgressBar(
                  progress: progress,
                  color: isCompleted
                      ? Colors.green
                      : (isPastDue ? Colors.red : colorScheme.primary),
                  backgroundColor: colorScheme.surfaceContainerHigh,
                  height: 4,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                isCompleted
                    ? 'DONE'
                    : (isPastDue ? 'OVER' : '${(progress * 100).toInt()}%'),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: isCompleted
                      ? Colors.green
                      : (isPastDue ? Colors.red : colorScheme.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            isCompleted
                ? 'Goal Completed!'
                : (isPastDue
                      ? 'Goal Expired'
                      : 'Saved: ${currencyFormat.format(currentBalance)}'),
            style: theme.textTheme.labelSmall?.copyWith(
              color: isCompleted
                  ? Colors.green
                  : (isPastDue ? Colors.red : colorScheme.onSurfaceVariant),
              fontWeight: isCompleted || isPastDue
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // lib/goals/screens/manage_goals_screen.dart

  void _showDeleteDialog(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        title: Text(
          'Delete Goal',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${goal.name}"?',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              HiveService.deleteGoal(goal.id);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
