import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../ledger/transaction_provider.dart';
import 'activity_list_item.dart';

class RecentActivitySection extends ConsumerWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Watch the transactions from the provider
    final summary = ref.watch(transactionsProvider);
    final transactions = summary.transactions;

    // Get only the most recent 3 transactions
    final recentTransactions = transactions.take(3).toList();

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.04),
            blurRadius: 40,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Recent Activity',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),

            ],
          ),
          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TRANSACTION',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                'STATUS',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          if (recentTransactions.isEmpty)
            Center(
              child: Text(
                'No activity yet.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: colorScheme.outline,
                ),
              ),
            )
          else
            ...recentTransactions.map((tx) => Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ActivityListItem(
                icon: _getIconForCategory(tx.category),
                title: tx.name,
                date: DateFormat('MMM dd, hh:mm a').format(tx.date),
                status: 'Completed',
                baseColor: tx.isMoneyIn ? colorScheme.primary : colorScheme.error,
              ),
            )),
        ],
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Food': return Icons.restaurant;
      case 'Bills': return Icons.receipt_long;
      case 'Shopping': return Icons.shopping_bag;
      case 'Transport': return Icons.directions_car;
      case 'Entertainment': return Icons.movie;
      case 'Health': return Icons.medical_services;
      case 'Business': return Icons.business_center;
      case 'Income': return Icons.payments;
      default: return Icons.category;
    }
  }
}
