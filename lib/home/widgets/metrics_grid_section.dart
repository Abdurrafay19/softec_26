import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../ledger/transaction_provider.dart';
import 'metric_tile.dart';

class MetricsGridSection extends ConsumerWidget {
  const MetricsGridSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the summary from the provider
    final summary = ref.watch(transactionsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    final formatter = NumberFormat.compactCurrency(symbol: '\$');

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MetricTile(
                icon: Icons.account_balance_wallet,
                title: 'NET CASH',
                amount: formatter.format(summary.netCash),
                iconColor: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MetricTile(
                icon: Icons.speed,
                title: 'BURN RATE',
                amount: formatter.format(summary.totalOutflow / 30), // Simple daily avg
                iconColor: colorScheme.tertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: MetricTile(
                icon: Icons.input,
                title: 'INFLOW',
                amount: formatter.format(summary.totalInflow),
                iconColor: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MetricTile(
                icon: Icons.output,
                title: 'OUTFLOW',
                amount: formatter.format(summary.totalOutflow),
                iconColor: colorScheme.error,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
