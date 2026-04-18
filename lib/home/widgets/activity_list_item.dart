import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String date;
  final String status; // 'Completed' or 'Pending'
  final Color baseColor;

  const ActivityListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.date,
    required this.status,
    required this.baseColor,
  });

  @override
  Widget build(BuildContext context) {
    // Access the global color scheme
    final colorScheme = Theme.of(context).colorScheme;
    final isCompleted = status == 'Completed';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Soft Icon Avatar using the provided baseColor with theme-friendly opacity
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: baseColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: baseColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),

        // Transaction Title & Date
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  // Uses onSurface for high-contrast primary text
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  // Uses onSurfaceVariant for lower-priority metadata
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // Status Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isCompleted
            // Completed uses secondaryContainer tint
                ? colorScheme.secondaryContainer.withValues(alpha: 0.2)
            // Pending uses a neutral surface container tint
                : colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            status,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isCompleted
                  ? colorScheme.onSecondaryContainer
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}