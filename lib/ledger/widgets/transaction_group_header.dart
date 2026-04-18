import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionGroupHeader extends StatelessWidget {
  final String title;

  const TransactionGroupHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      // The 8px left padding optically aligns the text with the text inside the cards
      padding: const EdgeInsets.only(left: 8.0, bottom: 16.0, top: 8.0),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5, // Heavy tracking for that premium editorial look
          color: colorScheme.outline, // Soft gray adapting to Light/Dark mode
        ),
      ),
    );
  }
}