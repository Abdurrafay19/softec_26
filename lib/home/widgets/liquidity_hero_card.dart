import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/add_transaction_sheet.dart';

class LiquidityHeroCard extends StatelessWidget {
  const LiquidityHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the global theme data
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Logic for trend visualization
    final double trendValue = 15.0;
    final bool isPositive = trendValue >= 0;

    // Define trend colors based on state
    final Color trendBaseColor = isPositive ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        // Uses surfaceContainerLowest from your AppTheme
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            // Uses onSurface for a tinted ambient shadow
            color: colorScheme.onSurface.withValues(alpha: 0.04),
            blurRadius: 40,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AVAILABLE LIQUIDITY',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              // Uses onSurfaceVariant for secondary text labels
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$248,590.22',
            style: GoogleFonts.manrope(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              letterSpacing: -2.0,
              color: colorScheme.onSurface,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: trendBaseColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: isPositive ? Colors.green.shade800 : Colors.red.shade800,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${isPositive ? '+' : ''}${trendValue.toStringAsFixed(1)}%',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isPositive ? Colors.green.shade800 : Colors.red.shade800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'vs last month',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}