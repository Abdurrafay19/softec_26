import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Added for consistent typography
import '../widgets/profile_hero.dart';
import '../widgets/settings_group_container.dart';
import '../widgets/settings_tile.dart';
import '../screens/theme_selection_screen.dart';
import '../../core/database/hive_service.dart';
import 'edit_profile_screen.dart';
import 'terms_conditions_screen.dart';
import '../../auth/screens/signup_screen.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _biometricsEnabled = false;

  @override
  void initState() {
    super.initState();
    _biometricsEnabled = HiveService.isBiometricsEnabled();
  }

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
                    ValueListenableBuilder(
                      valueListenable: HiveService.settingsListenable(),
                      builder: (context, box, child) {
                        final name = HiveService.getUserName().trim();
                        final displayName = name.isEmpty ? 'Your Name' : name;

                        return ProfileHeroSection(
                          displayName: displayName,
                          onEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 40),

                    _buildSectionTitle('Account Configuration', colorScheme),
                    const SizedBox(height: 16),
                    SettingsGroupContainer(
                      children: [
                        SettingsListTile(
                          icon: Icons.business_center_outlined,
                          title: 'Edit Profile',
                          subtitle: 'Update your display name',
                          iconColor: colorScheme.primary, // Adapts to wallpaper
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ),
                            );
                          },
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
                            onChanged: (value) async {
                              setState(() => _biometricsEnabled = value);
                              await HiveService.setBiometricsEnabled(value);
                            },
                            // Ties the active switch state to your dynamic primary color
                            activeThumbColor: colorScheme.primary,
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
                          icon: Icons.description_outlined,
                          title: 'Terms & Conditions',
                          subtitle: 'Read the terms of service',
                          iconColor: colorScheme.onSurfaceVariant,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TermsConditionsScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    
                    OutlinedButton.icon(
                      onPressed: () async {
                        final bool? shouldDelete = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete account?'),
                              content: const Text(
                                'This will remove your local data, including your name and transactions.',
                                style: TextStyle(
                                color: Color(0xFF555555), // Replaced hardcoded grey
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );

                        if (shouldDelete != true) {
                          return;
                        }

                        await HiveService.deleteAccountData();

                        if (!mounted) {
                          return;
                        }

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Delete Account'),
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