import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFFF7F9FF);
  static const Color primary = Color(0xFF005BBF);
  static const Color onSurface = Color(0xFF181C20);
  static const Color primaryContainer = Color(0xFF1A73E8);

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.robotoFlexTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        surface: background,
        onSurface: onSurface,
        primary: primary,
        primaryContainer: primaryContainer,
      ),
      // The "Ambient Shadow" Card Override
      cardTheme: const CardThemeData(
        elevation: 0,
        color: Colors.white,
        margin: EdgeInsets.zero,
      ),
      textTheme: baseTextTheme.copyWith(
        displayMedium: GoogleFonts.manrope(
          textStyle: baseTextTheme.displayMedium,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.02,
          color: onSurface,
        ),
        headlineLarge: GoogleFonts.manrope(
          textStyle: baseTextTheme.headlineLarge,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.02,
          color: onSurface,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
      ),
    );
  }
}