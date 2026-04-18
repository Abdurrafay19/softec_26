import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'insight_row.dart';

class SmartInsightsCard extends StatelessWidget {
  const SmartInsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white, // surface-container-lowest
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          // Ambient shadow matching DESIGN.md
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
          // Header
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Color(0xFF005BBF), size: 24),
              const SizedBox(width: 8),
              Text(
                'Smart Insights',
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF181C20),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Insight 1: Invoice Paid (Secondary/Cyan Tint)
          InsightRow(
            icon: Icons.payments,
            title: 'Invoice #884 Paid',
            subtitle: 'Early payment discount applied by Client X.',
            // Using withValues to match the HTML bg-secondary-container/20
            rowBackgroundColor: const Color(0xFF69E8FE).withValues(alpha: 0.2),
            iconBackgroundColor: const Color(0xFF69E8FE),
            iconColor: const Color(0xFF006774),
          ),

          const SizedBox(height: 16),

          // Insight 2: Rent Due (Tertiary/Orange Tint)
          InsightRow(
            icon: Icons.schedule,
            title: 'Rent Due Tomorrow',
            subtitle: 'Automatic transfer of \$3,500 scheduled.',
            // Using withValues to match the HTML bg-tertiary-container/10
            rowBackgroundColor: const Color(0xFFC55500).withValues(alpha: 0.1),
            iconBackgroundColor: const Color(0xFFC55500).withValues(alpha: 0.3),
            iconColor: const Color(0xFF9E4300),
          ),

          const SizedBox(height: 24),

          // Tertiary CTA Button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                // Hover/splash effect using primary color with high transparency
                foregroundColor: const Color(0xFF005BBF),
              ),
              onPressed: () {},
              child: Text(
                'View All Alerts',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF005BBF), // primary
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}