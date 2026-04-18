import 'package:flutter/material.dart';
import 'metric_tile.dart';

class MetricsGridSection extends StatelessWidget {
  const MetricsGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MetricTile(
                icon: Icons.account_balance_wallet,
                title: 'NET CASH',
                amount: '\$14.2k',
                iconColor: Color(0xFF006876), // secondary
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: MetricTile(
                icon: Icons.speed,
                title: 'BURN RATE',
                amount: '\$8.4k',
                iconColor: Color(0xFF9E4300), // tertiary
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: MetricTile(
                icon: Icons.input,
                title: 'INFLOW',
                amount: '\$42.1k',
                iconColor: Color(0xFF005BBF), // primary
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: MetricTile(
                icon: Icons.output,
                title: 'OUTFLOW',
                amount: '\$27.9k',
                iconColor: Color(0xFFBA1A1A), // error
              ),
            ),
          ],
        ),
      ],
    );
  }
}