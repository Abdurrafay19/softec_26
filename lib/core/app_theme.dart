import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Fallback brand colors (only used if Dynamic Color is unavailable)
  static const Color richBlue = Color(0xFF005BBF);
  static const Color lightBg = Color(0xFFF7F9FF);
  static const Color darkBg = Color(0xFF181C20);

  static ThemeData lightTheme(ColorScheme? dynamicScheme) {
    // If dynamicScheme exists, we use it directly for 100% device accuracy.
    // If not, we fall back to our hardcoded brand scheme.
    final scheme = dynamicScheme ?? ColorScheme.fromSeed(
      seedColor: richBlue,
      brightness: Brightness.light,
      surface: lightBg,
    );

    return _buildTheme(Brightness.light, scheme);
  }

  static ThemeData darkTheme(ColorScheme? dynamicScheme) {
    final scheme = dynamicScheme ?? ColorScheme.fromSeed(
      seedColor: richBlue,
      brightness: Brightness.dark,
      surface: darkBg,
    );

    return _buildTheme(Brightness.dark, scheme);
  }

  static ThemeData _buildTheme(Brightness brightness, ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      // Ensure cards and surfaces use the dynamic container tokens
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLowest,
        margin: EdgeInsets.zero,
      ),
      // Apply Google Fonts while respecting the dynamic onSurface color
      textTheme: GoogleFonts.interTextTheme().copyWith(
        headlineLarge: GoogleFonts.manrope(
          fontWeight: FontWeight.w800,
          color: scheme.onSurface,
        ),
      ),
    );
  }
}