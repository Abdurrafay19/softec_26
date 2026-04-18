import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Added for consistent typography
import '../widgets/profile_hero.dart';
import '../widgets/settings_group_container.dart';
import '../widgets/settings_tile.dart';
import '../screens/theme_selection_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _biometricsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      // Let the main navigation's dynamic surface background bleed through
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                // Maintains the 120px bottom padding to clear the frosted glass BottomNav
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const ProfileHeroSection(),
                    const SizedBox(height: 40),

                    _buildSectionTitle('Account Configuration', colorScheme),
                    const SizedBox(height: 16),
                    SettingsGroupContainer(
                      children: [
                        SettingsListTile(
                          icon: Icons.business_center_outlined,
                          title: 'Edit Business Profile',
                          subtitle: 'Tax ID, Billing Address, and Legal Entity',
                          iconColor: colorScheme.primary, // Adapts to wallpaper
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    _buildSectionTitle('App Preferences', colorScheme),
                    const SizedBox(height: 16),
                    SettingsGroupContainer(
                      children: [
                        SettingsListTile(
                          icon: Icons.fingerprint_outlined,
                          title: 'Biometric Login',
                          subtitle: 'Use FaceID or Fingerprint for security',
                          iconColor: colorScheme.secondary,
                          trailing: Switch(
                            value: _biometricsEnabled,
                            onChanged: (value) => setState(() => _biometricsEnabled = value),
                            // Ties the active switch state to your dynamic primary color
                            activeColor: colorScheme.primary,
                          ),
                        ),
                        SettingsListTile(
                          icon: Icons.palette_outlined,
                          title: 'Visual Appearance',
                          subtitle: 'Light theme active',
                          iconColor: colorScheme.tertiary,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ThemeSelectionScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    _buildSectionTitle('Support & Legal', colorScheme),
                    const SizedBox(height: 16),
                    SettingsGroupContainer(
                      children: [
                        SettingsListTile(
                          icon: Icons.policy_outlined,
                          title: 'Privacy & Legal',
                          subtitle: 'Privacy Policy, Terms of Service',
                          // A neutral color for less critical UI elements
                          iconColor: colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Dynamic Sign Out Button
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout),
                      label: const Text('Sign Out of Account'),
                      style: OutlinedButton.styleFrom(
                        // Automatically uses the system's designated error color
                        foregroundColor: colorScheme.error,
                        side: BorderSide(
                          color: colorScheme.error.withValues(alpha: 0.3),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Dynamic Version Text
                    Center(
                      child: Text(
                        'VERSION 2.4.0 (GOLD)',
                        style: GoogleFonts.inter(
                          color: colorScheme.outline, // Replaced hardcoded grey
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Refactored to accept colorScheme and use consistent GoogleFonts
  Widget _buildSectionTitle(String title, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: colorScheme.outline, // Perfectly adapts to light/dark surfaces
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}