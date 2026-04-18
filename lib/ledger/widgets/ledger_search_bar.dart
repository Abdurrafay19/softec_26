import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LedgerSearchBar extends StatelessWidget {
  const LedgerSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          // 4% ambient shadow using the dynamic onSurface color
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        style: GoogleFonts.inter(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Search transactions, vendors, or amount...',
          hintStyle: GoogleFonts.inter(
            color: colorScheme.outline,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 12.0),
            child: Icon(
              Icons.search,
              color: colorScheme.outline,
              size: 24,
            ),
          ),
          // Removes the default ugly underline
          border: InputBorder.none,
          // Thick padding for the "editorial breathing room"
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}