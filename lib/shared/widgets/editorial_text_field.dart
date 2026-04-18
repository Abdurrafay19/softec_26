import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditorialTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? helperText;
  final bool isPassword;
  final Widget? trailingLabelAction;
  final TextEditingController? controller; // Added controller

  const EditorialTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.helperText,
    this.isPassword = false,
    this.trailingLabelAction,
    this.controller, // Added controller
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
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            if (trailingLabelAction != null) trailingLabelAction!, // Fixed syntax error
          ],
        ),
        TextFormField(
          controller: controller, // Added controller
          obscureText: isPassword,
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
