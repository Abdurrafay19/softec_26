import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditorialTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? helperText;
  final bool isPassword;
  final Widget? trailingLabelAction;

  const EditorialTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.helperText,
    this.isPassword = false,
    this.trailingLabelAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  // Changed from 'secondary' to 'onSurface' to maintain the strict,
                  // professional editorial voice instead of looking too colorful.
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            ?trailingLabelAction,
          ],
        ),
        TextFormField(
          obscureText: isPassword,
          // Ensures the typed text adapts to light/dark mode
          style: GoogleFonts.inter(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
              color: colorScheme.outline,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            // Replaced 0xFFE5E8EE with the exact token requested in DESIGN.md
            fillColor: colorScheme.surfaceContainerHighest,
            contentPadding: const EdgeInsets.all(16),
            border: const UnderlineInputBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              helperText!,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ],
    );
  }
}