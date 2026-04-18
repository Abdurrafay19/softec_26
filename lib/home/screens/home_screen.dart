import 'package:flutter/material.dart';
import '../widgets/liquidity_hero_card.dart';
import '../widgets/cash_flow_trends_card.dart';
import '../widgets/metrics_grid_section.dart'; // We will build this next!

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // 120px bottom padding clears the floating nav bar
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
      children: const [
        LiquidityHeroCard(),
        SizedBox(height: 24),
        CashFlowTrendsCard(),
        SizedBox(height: 24),
        // Drop Phase 2 in right here:
        MetricsGridSection(),

        // (Phases 3 and 4 will stack below this)
      ],
    );
  }
}