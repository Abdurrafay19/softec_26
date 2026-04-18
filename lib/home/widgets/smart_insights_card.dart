import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'insight_row.dart';

class SmartInsightsCard extends StatelessWidget {
  const SmartInsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest, // #ffffff in Light Mode
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
            children: [
              Icon(Icons.auto_awesome, color: colorScheme.primary, size: 24),
              const SizedBox(width: 8),
              Text(
                'Smart Insights',
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          InsightRow(
            icon: Icons.payments,
            title: 'Invoice #884 Paid',
            subtitle: 'Early payment discount applied by Client X.',
            baseThemeColor: colorScheme.secondary,
            onBaseColor: colorScheme.onSecondaryContainer,
          ),
          const SizedBox(height: 16),
          InsightRow(
            icon: Icons.schedule,
            title: 'Rent Due Tomorrow',
            subtitle: 'Automatic transfer of \$3,500 scheduled.',
            baseThemeColor: colorScheme.tertiary,
            onBaseColor: colorScheme.onTertiaryFixedVariant,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'View All Alerts',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}