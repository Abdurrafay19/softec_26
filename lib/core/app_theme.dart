import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- CORE PALETTE FROM DESIGN.MD ---
  static const Color richBlue = Color(0xFF005BBF);
  static const Color lightBg = Color(0xFFF7F9FF);
  static const Color darkBg = Color(0xFF181C20); // on-surface from light becomes bg in dark

  // --- LIGHT THEME DATA ---
  static ThemeData get lightTheme {
    return _buildTheme(
      Brightness.light,
      const ColorScheme.light(
        primary: richBlue,
        onPrimary: Colors.white,
        primaryContainer: Color(0xFF1A73E8),
        onPrimaryContainer: Colors.white,
        secondary: Color(0xFF006876),
        secondaryContainer: Color(0xFF69E8FE),
        surface: lightBg,
        onSurface: Color(0xFF181C20),
        surfaceContainerLow: Color(0xFFF1F4FA),
        surfaceContainerLowest: Colors.white,
        outlineVariant: Color(0xFFC1C6D6),
      ),
    );
  }

  // --- DARK THEME DATA ---
  static ThemeData get darkTheme {
    return _buildTheme(
      Brightness.dark,
      const ColorScheme.dark(
        primary: Color(0xFFADC7FF), // primary-fixed-dim
        onPrimary: Color(0xFF002F66),
        primaryContainer: Color(0xFF004494),
        surface: darkBg,
        onSurface: Color(0xFFE2E2E6),
        surfaceContainerLow: Color(0xFF23262A),
        surfaceContainerLowest: Color(0xFF1C1F23),
      ),
    );
  }

  // Common Theme Logic
  static ThemeData _buildTheme(Brightness brightness, ColorScheme scheme) {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLowest,
        margin: EdgeInsets.zero,
      ),
      textTheme: baseTextTheme.copyWith(
        headlineLarge: GoogleFonts.manrope(
          fontWeight: FontWeight.w800,
          color: scheme.onSurface,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
      ),
    );
  }
}