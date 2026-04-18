import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 20.0),
          child: Text(
            'Monthly Statistics',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
              letterSpacing: -0.5,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: MetricTile(
                icon: Icons.account_balance_wallet,
                title: 'NET CASH',
                amount: formatter.format(summary.monthlyNetCash),
                iconColor: colorScheme.primary,
                info: 'Inflow - Outflow',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MetricTile(
                icon: Icons.speed,
                title: 'BURN RATE',
                amount: formatter.format(summary.monthlyBurnRate),
                iconColor: colorScheme.tertiary,
                info: 'Avg. daily spending',
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
                amount: formatter.format(summary.monthlyInflow),
                iconColor: colorScheme.primary,
                info: 'Total income',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MetricTile(
                icon: Icons.output,
                title: 'OUTFLOW',
                amount: formatter.format(summary.monthlyOutflow),
                iconColor: colorScheme.error,
                info: 'Total expenses',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
