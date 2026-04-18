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
    final isCompleted = status == 'Completed';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Soft Icon Avatar
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
                  color: const Color(0xFF181C20), // on-surface
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF414754), // on-surface-variant
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
                ? const Color(0xFF69E8FE).withValues(alpha: 0.2) // cyan tint
                : const Color(0xFFE5E8EE), // gray tint for pending
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            status,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isCompleted
                  ? const Color(0xFF006774) // dark cyan
                  : const Color(0xFF414754), // dark gray
            ),
          ),
        ),
      ],
    );
  }
}