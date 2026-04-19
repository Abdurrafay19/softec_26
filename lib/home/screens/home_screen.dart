import 'package:flutter/material.dart';

// Import all modular components
import '../widgets/liquidity_hero_card.dart';
import '../widgets/cash_flow_trends_card.dart';
import '../widgets/metrics_grid_section.dart';
import '../widgets/smart_insights_card.dart';
import '../widgets/recent_activity_section.dart';
import '../widgets/add_transaction_sheet.dart';
import '../widgets/goals_card.dart';

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

          GoalsCard(),
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
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              // Added the premium glowing shadow to match your PrimaryButton
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.3),
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
                // --- The Magic Modal Call ---
                showModalBottomSheet(
                  context: context,
                  // isScrollControlled is REQUIRED to let the modal slide up with the keyboard
                  isScrollControlled: true,
                  // Makes the default background invisible so our 24px rounded corners show up
                  backgroundColor: Colors.transparent,
                  builder: (context) => const AddTransactionSheet(),
                );
              },
              child: Icon(
                Icons.add,
                color: colorScheme.onPrimary,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
