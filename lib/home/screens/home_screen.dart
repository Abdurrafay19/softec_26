import 'package:flutter/material.dart';

// Import all your beautiful modular components
import '../widgets/liquidity_hero_card.dart';
import '../widgets/cash_flow_trends_card.dart';
import '../widgets/metrics_grid_section.dart';
import '../widgets/smart_insights_card.dart';
import '../widgets/recent_activity_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Step 5.1: Scaffold with a transparent background to blend with MainNavigationScreen
    return Scaffold(
      backgroundColor: Colors.transparent,

      // Step 5.2: The stacked ListView
      body: ListView(
        // 120px bottom padding ensures the last item clears the bottom navigation bar
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
        children: const [
          LiquidityHeroCard(),
          SizedBox(height: 24),

          CashFlowTrendsCard(),
          SizedBox(height: 24),

          MetricsGridSection(),
          SizedBox(height: 24),

          SmartInsightsCard(),
          SizedBox(height: 24),

          RecentActivitySection(),
        ],
      ),

      // Step 5.3: The Contextual Floating Action Button
      floatingActionButton: Padding(
        // Pushes the FAB up so it doesn't collide with your custom floating bottom nav
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF005BBF), // primary
            borderRadius: BorderRadius.circular(16), // Softer rounding (like the HTML)
            boxShadow: [
              // Colored ambient shadow matching the DESIGN.md rules
              BoxShadow(
                color: const Color(0xFF005BBF).withValues(alpha: 0.4),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // TODO: Wire this up to a transaction modal later!
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}