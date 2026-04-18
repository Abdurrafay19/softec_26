// lib/analytics/screens/analytics_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/projected_balance_card.dart';
import '../widgets/scenario_simulation.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override

  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
      children: [
        Text(
          'Cash Flow Forecast',
          style: GoogleFonts.manrope(
            fontSize: 38,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.secondary,
            letterSpacing: -1.5,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Visualizing your liquidity trajectory based on current receivables, scheduled expenses, and predictive market modeling.',
          style: GoogleFonts.inter(
            fontSize: 16,
            height: 1.6,
            color: const Color(0xFF414754),
          ),
        ),
        const SizedBox(height: 40),
        const ProjectedBalanceCard(),
        const SizedBox(height: 24),
        const ScenarioSimulation(),
      ],
    );
  }
}