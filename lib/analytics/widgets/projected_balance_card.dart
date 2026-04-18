import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectedBalanceCard extends StatelessWidget {
  const ProjectedBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white, // Surface Container Lowest
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            // Modern syntax replacing withOpacity
            color: const Color(0xFF181C20).withValues(alpha: 0.25),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Subtle background watermark icon
          Positioned(
            top: -10,
            right: -10,
            child: Icon(
              Icons.account_balance_wallet,
              size: 100,
              color: const Color(0xFF181C20).withValues(alpha: 0.02),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Projected Month-End Balance',
                style: GoogleFonts.robotoFlex(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF414754), // on-surface-variant
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$142,850.00',
                    style: GoogleFonts.notoSerif(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF005BBF), // primary
                      letterSpacing: -1.5,
                      // tnum: ensures decimals align perfectly
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        const Icon(Icons.trending_up, color: Color(0xFF006876), size: 16), // secondary
                        const SizedBox(width: 4),
                        Text(
                          '+12.4%',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF006876),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // AI Validation Row with Overlapping Avatars
              Row(
                children: [
                  SizedBox(
                    width: 52,
                    height: 32,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              color: const Color(0xFFDFE3E8),
                            ),
                            child: const Icon(Icons.person, size: 20, color: Color(0xFF727785)),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              color: const Color(0xFFD8E2FF), // primary-fixed
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'AI',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF001A41),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Validated by AI Architect and your lead accountant',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF414754),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}