import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CashFlowTrendsCard extends StatelessWidget {
  const CashFlowTrendsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Wrap the text column in Expanded so it shrinks/wraps safely
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cash Flow Trends',
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF181C20),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Projection for the next 30 days',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF414754),
                      ),
                    ),
                  ],
                ),
              ),
              // 2. Add a little breathing room between the text and the toggle
              const SizedBox(width: 16),
              // 3. The toggle remains un-expanded so it keeps its exact shape
              _buildSegmentedToggle(),
            ],
          ),
          const SizedBox(height: 32),
          _buildMockChart(),
          const SizedBox(height: 16),
          _buildXAxisLabels(),
        ],
      ),
    );
  }

  Widget _buildSegmentedToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4FA), // surface-container-low
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildToggleOption('1M', true),
          _buildToggleOption('3M', false),
          _buildToggleOption('6M', false),
        ],
      ),
    );
  }

  Widget _buildToggleOption(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected
            ? [
          BoxShadow(
            color: const Color(0xFF181C20).withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ]
            : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? const Color(0xFF181C20) : const Color(0xFF414754),
        ),
      ),
    );
  }

  // Step 1.3: The Stylized Mock Chart
  Widget _buildMockChart() {
    // Heights as percentages (0.0 to 1.0)
    final barHeights = [0.4, 0.6, 0.55, 0.8, 0.95, 0.85, 0.7, 0.65];
    // Opacities matching the visual depth in the HTML design
    final barOpacities = [0.1, 0.1, 0.2, 0.1, 0.1, 0.3, 0.1, 0.1];
    // The two highlighted bars with top borders
    final isHighlighted = [false, false, true, false, false, true, false, false];

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
                  color: const Color(0xFF005BBF).withValues(alpha: barOpacities[index]),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  border: isHighlighted[index]
                      ? const Border(top: BorderSide(color: Color(0xFF005BBF), width: 2))
                      : null,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildXAxisLabels() {
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
                color: const Color(0xFF414754), // on-surface-variant
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}