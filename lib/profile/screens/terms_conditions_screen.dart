import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        title: Text(
          'Terms & Conditions',
          style: GoogleFonts.manrope(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            Text(
              'Last updated: April 18, 2026',
              style: GoogleFonts.inter(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _sectionTitle(context, '1. Acceptance of Terms'),
            _paragraph(
              context,
              'By using this app, you agree to these terms and any updates. If you do not agree, do not use the app.',
            ),
            _sectionTitle(context, '2. Use of the App'),
            _paragraph(
              context,
              'Use the app for lawful purposes only. You are responsible for maintaining the confidentiality of your account and device.',
            ),
            _sectionTitle(context, '3. Data and Privacy'),
            _paragraph(
              context,
              'Your data is stored locally on your device unless otherwise specified. You are responsible for backups and device security.',
            ),
            _sectionTitle(context, '4. Limitation of Liability'),
            _paragraph(
              context,
              'The app is provided "as is" without warranties. We are not liable for any damages or losses arising from use of the app.',
            ),
            _sectionTitle(context, '5. Changes to Terms'),
            _paragraph(
              context,
              'We may update these terms from time to time. Continued use of the app means you accept the revised terms.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _paragraph(BuildContext context, String text) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      text,
      style: GoogleFonts.inter(
        color: colorScheme.onSurfaceVariant,
        fontSize: 13,
        height: 1.5,
      ),
    );
  }
}
