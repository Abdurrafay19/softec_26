import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'activity_list_item.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the theme for consistent styling across light and dark modes
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        // Uses surfaceContainerLowest for the primary card surface
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          // Ambient shadow tied to the theme's surface color
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
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Recent\nActivity',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.primary, // Tied to primary theme color
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                iconAlignment: IconAlignment.end,
                icon: const Icon(Icons.download, size: 18),
                label: Text(
                  'Download\nCSV',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Column Headers following the "Editorial Voice" guidelines
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TRANSACTION',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                'STATUS',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Data Rows using the finalized ActivityListItem
          ActivityListItem(
            icon: Icons.cloud,
            title: 'AWS Infrastructure',
            date: 'Today, 2:45 PM',
            status: 'Completed',
            baseColor: colorScheme.primary,
          ),
          const SizedBox(height: 24),

          ActivityListItem(
            icon: Icons.face,
            title: 'Stripe Inflow: Client Z',
            date: 'Yesterday, 11:20 AM',
            status: 'Completed',
            baseColor: colorScheme.secondary,
          ),
          const SizedBox(height: 24),

          ActivityListItem(
            icon: Icons.store,
            title: 'Apple Store Purchase',
            date: 'Oct 24, 09:15 AM',
            status: 'Pending',
            baseColor: colorScheme.tertiary,
          ),
        ],
      ),
    );
  }
}