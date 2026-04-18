import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CashFlowTrendsCard extends StatelessWidget {
  const CashFlowTrendsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the dynamic color scheme
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budget Trend',
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildMockChart(colorScheme),
          const SizedBox(height: 16),
          _buildXAxisLabels(colorScheme),
        ],
      ),
    );
  }

  Widget _buildMockChart(ColorScheme colorScheme) {
    final barHeights = [0.4, 0.6, 0.55, 0.8, 0.95, 0.85, 0.7, 0.65];
    return SizedBox(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(8, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                height: 160 * barHeights[index],
                decoration: BoxDecoration(
                  // Use primaryContainer for the soft bars and primary for the borders
                  color: colorScheme.primary.withValues(alpha: 0.75),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildXAxisLabels(ColorScheme colorScheme) {
    final labels = ['WK 01', 'WK 02', 'WK 03', 'WK 04', 'WK 05', 'WK 06', 'WK 07', 'WK 08'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: labels.map((label) {
        return Expanded(
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}