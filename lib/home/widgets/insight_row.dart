import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InsightRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  // Pass the semantic color (e.g., colorScheme.secondary or colorScheme.tertiary)
  final Color baseThemeColor;
  final Color onBaseColor;

  const InsightRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.baseThemeColor,
    required this.onBaseColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Dynamically creates the soft tint from the theme color
        color: baseThemeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: baseThemeColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: onBaseColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}