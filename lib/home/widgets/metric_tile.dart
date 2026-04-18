import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MetricTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final Color iconColor;

  const MetricTile({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4FA), // surface-container-low
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: const Color(0xFF414754), // on-surface-variant
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF181C20), // on-surface
              // Tabular figures keep the decimal structures perfectly aligned
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}