import 'package:flutter/material.dart';

class HomeInsightsWidget extends StatelessWidget {
  final double inflowAmount;
  final double outflowAmount;

  const HomeInsightsWidget({
    super.key,
    this.inflowAmount = 24500.00, // Dummy data for layout testing
    this.outflowAmount = 14200.00,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final netBalance = inflowAmount - outflowAmount;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(24, 28, 32, 0.06),
            offset: Offset(0, 12),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Financial Insights',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              Icon(
                Icons.insights_rounded,
                color: colorScheme.primary,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Main Balance Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Net Balance',
                      style: TextStyle(
                        color: colorScheme.onPrimary.withValues(alpha: 0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${netBalance.toStringAsFixed(2)}',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        netBalance >= 0 ? Icons.trending_up : Icons.trending_down,
                        color: colorScheme.onPrimary,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '12.5%', // Replace with actual calculated growth
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Inflow / Outflow Row
          Row(
            children: [
              Expanded(
                child: _buildCashFlowStat(
                  context: context,
                  label: 'Total Inflow',
                  amount: inflowAmount,
                  icon: Icons.arrow_downward_rounded,
                  iconColor: Colors.green.shade600,
                  bgColor: Colors.green.shade50,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCashFlowStat(
                  context: context,
                  label: 'Total Outflow',
                  amount: outflowAmount,
                  icon: Icons.arrow_upward_rounded,
                  iconColor: theme.colorScheme.error,
                  bgColor: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCashFlowStat({
    required BuildContext context,
    required String label,
    required double amount,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FF), // Matching your app's background color
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 14,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '\$${amount.toStringAsFixed(0)}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}