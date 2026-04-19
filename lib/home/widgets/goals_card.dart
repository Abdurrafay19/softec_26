import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../core/database/hive_service.dart';
import '../../goals/models/goal.dart';
import '../../goals/screens/manage_goals_screen.dart';
import '../../shared/widgets/wavy_progress_bar.dart';
import '../../ledger/transaction_provider.dart';

class GoalsCard extends ConsumerWidget {
  const GoalsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currencyFormat = NumberFormat.currency(symbol: r'$', decimalDigits: 0);
    
    // Watch the current total balance from the ledger
    final currentBalance = ref.watch(transactionsProvider.select((s) => s.totalBalance));

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Financial Goals',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              Icon(Icons.flag_rounded, color: colorScheme.primary),
            ],
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: HiveService.goalsListenable(),
            builder: (context, box, _) {
              final goals = box.values.toList();

              if (goals.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Set your first financial milestone to track progress.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              }

              return Column(
                children: goals.take(3).map((goal) {
                  final progress = (currentBalance / goal.targetAmount).clamp(0.0, 1.0);
                  final isCompleted = currentBalance >= goal.targetAmount;
                  final isPastDue = goal.dueDate != null && 
                                   goal.dueDate!.isBefore(DateTime.now()) && 
                                   !isCompleted;
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isCompleted 
                            ? Colors.green.withValues(alpha: 0.5)
                            : (isPastDue ? Colors.red.withValues(alpha: 0.5) : colorScheme.outlineVariant.withValues(alpha: 0.3)),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              goal.name,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
                                decoration: isCompleted ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            if (isCompleted)
                              const Icon(Icons.check_circle, color: Colors.green, size: 20)
                            else if (isPastDue)
                              const Icon(Icons.error_outline, color: Colors.red, size: 20)
                            else
                              Text(
                                '${(progress * 100).toInt()}%',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        WavyProgressBar(
                          progress: progress,
                          color: isCompleted ? Colors.green : (isPastDue ? Colors.red : colorScheme.primary),
                          backgroundColor: colorScheme.surfaceContainerHigh,
                          height: 4,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isCompleted 
                                ? 'Goal Completed!' 
                                : (isPastDue ? 'Due Date Passed' : '${currencyFormat.format(currentBalance)} saved'),
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: isCompleted ? Colors.green : (isPastDue ? Colors.red : colorScheme.onSurfaceVariant),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Target: ${currencyFormat.format(goal.targetAmount)}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageGoalsScreen()),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: colorScheme.outlineVariant),
                shape: RoundedRectangleType(16),
              ),
              child: Text(
                'Manage Goals',
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedRectangleType extends RoundedRectangleBorder {
  RoundedRectangleType(double radius) : super(borderRadius: BorderRadius.circular(radius));
}
