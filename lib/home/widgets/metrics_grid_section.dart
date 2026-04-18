import 'package:flutter/material.dart';
import 'metric_tile.dart';

class MetricsGridSection extends StatelessWidget {
  const MetricsGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MetricTile(
                icon: Icons.account_balance_wallet,
                title: 'NET CASH',
                amount: '\$14.2k',
                // Secondary color is used for "Net Cash" per your HTML design
                iconColor: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MetricTile(
                icon: Icons.speed,
                title: 'BURN RATE',
                amount: '\$8.4k',
                // Tertiary color is used for "Burn Rate"
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
                amount: '\$42.1k',
                iconColor: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MetricTile(
                icon: Icons.output,
                title: 'OUTFLOW',
                amount: '\$27.9k',
                iconColor: colorScheme.error,
              ),
            ),
          ],
        ),
      ],
    );
  }
}