import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/logo.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 24),
            // App Name
            Text(
              'The Fiscal Architect',
              style: GoogleFonts.manrope(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: colorScheme.primary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 48),
            // Spinner Loader
            CircularProgressIndicator(
              strokeWidth: 3,
              color: colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
