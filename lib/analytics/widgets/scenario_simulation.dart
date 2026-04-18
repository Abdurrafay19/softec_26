import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScenarioSimulation extends StatefulWidget {
  const ScenarioSimulation({super.key});

  @override
  State<ScenarioSimulation> createState() => _ScenarioSimulationState();
}

class _ScenarioSimulationState extends State<ScenarioSimulation> {
  // Local state for the sliders
  int _paymentDelay = 14;
  int _newHires = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        // The "Ghost Border" fallback from DESIGN.md (outline_variant at 15% opacity)
        border: Border.all(
          color: const Color(0xFFC1C6D6).withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF181C20).withValues(alpha: 0.04), // Ambient Shadow
            blurRadius: 24,
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
              const Icon(Icons.science, color: Color(0xFF005BBF)),
              const SizedBox(width: 8),
              Text(
                'Scenario Simulation',
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

          // Slider 1: Late Payment Delay
          _buildSliderSection(
            label: 'Late Payment Delay',
            valueText: '$_paymentDelay Days',
            value: _paymentDelay.toDouble(),
            min: 0,
            max: 60,
            description: 'Simulates cash gap if top 5 clients delay payments.',
            onChanged: (val) {
              setState(() {
                _paymentDelay = val.toInt();
              });
            },
          ),

          const SizedBox(height: 28),

          // Slider 2: Planned New Hires
          _buildSliderSection(
            label: 'Planned New Hires',
            valueText: '$_newHires Staff',
            value: _newHires.toDouble(),
            min: 0,
            max: 10,
            description: 'Impact on monthly burn rate and payroll obligations.',
            onChanged: (val) {
              setState(() {
                _newHires = val.toInt();
              });
            },
          ),
        ],
      ),
    );
  }

  // Helper method to keep code DRY and build the premium slider layout
  Widget _buildSliderSection({
    required String label,
    required String valueText,
    required double value,
    required double min,
    required double max,
    required String description,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF181C20),
              ),
            ),
            // Data Pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E8EE), // surface-container-high
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                valueText,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF181C20),
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Custom Styled Material Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 8,
            activeTrackColor: const Color(0xFF005BBF), // primary
            inactiveTrackColor: const Color(0xFFDFE3E8), // surface-container-highest
            thumbColor: const Color(0xFF005BBF),
            overlayColor: const Color(0xFF005BBF).withValues(alpha: 0.1),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 10,
              elevation: 4,
            ),
            trackShape: const RoundedRectSliderTrackShape(),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: max.toInt(), // Makes it snap to whole numbers
            onChanged: onChanged,
          ),
        ),

        const SizedBox(height: 4),
        Text(
          description,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontStyle: FontStyle.italic,
            color: const Color(0xFF414754), // on-surface-variant
          ),
        ),
      ],
    );
  }
}