import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'activity_list_item.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white, // surface-container-lowest
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF181C20).withValues(alpha: 0.04),
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
                style: GoogleFonts.manrope(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF181C20),
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF005BBF), // primary
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                // Reversing the icon to be on the right to match design
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

          // Column Headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TRANSACTION',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: const Color(0xFF414754),
                ),
              ),
              Text(
                'STATUS',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: const Color(0xFF414754),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Data Rows (Using spacing instead of dividers per DESIGN.md)
          const ActivityListItem(
            icon: Icons.cloud,
            title: 'AWS Infrastructure',
            date: 'Today, 2:45 PM',
            status: 'Completed',
            baseColor: Color(0xFF005BBF), // primary
          ),
          const SizedBox(height: 24),

          const ActivityListItem(
            icon: Icons.face,
            title: 'Stripe Inflow: Client Z',
            date: 'Yesterday, 11:20 AM',
            status: 'Completed',
            baseColor: Color(0xFF006876), // secondary
          ),
          const SizedBox(height: 24),

          const ActivityListItem(
            icon: Icons.store,
            title: 'Apple Store Purchase',
            date: 'Oct 24, 09:15 AM',
            status: 'Pending',
            baseColor: Color(0xFF9E4300), // tertiary
          ),
        ],
      ),
    );
  }
}