import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // Swapped the gradient back to a solid dynamic color
        color: colorScheme.primary,
        boxShadow: [
          // Keeping the dynamic colored ambient shadow
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            offset: const Offset(0, 8),
            blurRadius: 24,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: colorScheme.onPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(icon, color: colorScheme.onPrimary, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}