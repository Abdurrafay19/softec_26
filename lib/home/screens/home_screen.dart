import 'package:flutter/material.dart';

// Import all modular components
import '../widgets/liquidity_hero_card.dart';
import '../widgets/cash_flow_trends_card.dart';
import '../widgets/metrics_grid_section.dart';
import '../widgets/smart_insights_card.dart';
import '../widgets/recent_activity_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the global theme tokens
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      // Keep transparent to show the background color from MainNavigationScreen
      backgroundColor: Colors.transparent,

      body: ListView(
        // Padding follows the "Editorial Voice" rule for breathing room
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

      // Step 5.3: Updated Contextual Floating Action Button
      floatingActionButton: Padding(
        // Pushes the FAB up to clear the custom floating bottom navigation bar
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: colorScheme.primary, // Tied to universal theme
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // TODO: Wire this up to a transaction modal later
              },
              child: Icon(
                Icons.add,
                color: colorScheme.onPrimary, // High-contrast icon color
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}