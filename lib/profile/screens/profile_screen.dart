import 'package:flutter/material.dart';
import '../widgets/profile_hero.dart';
import '../widgets/settings_group_container.dart';
import '../widgets/settings_tile.dart';

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
      backgroundColor: const Color(0xFFF7F9FF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const ProfileHeroSection(),
                    const SizedBox(height: 40),
                    _buildSectionTitle('Account Configuration', theme),
                    const SizedBox(height: 16),
                    SettingsGroupContainer(
                      children: [
                        SettingsListTile(
                          icon: Icons.business_center_outlined,
                          title: 'Edit Business Profile',
                          subtitle: 'Tax ID, Billing Address, and Legal Entity',
                          iconColor: colorScheme.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('App Preferences', theme),
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
                          //  activeColor: colorScheme.primary,
                          ),
                        ),
                        SettingsListTile(
                          icon: Icons.palette_outlined,
                          title: 'Visual Appearance',
                          subtitle: 'Light theme active',
                          iconColor: colorScheme.secondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Support & Legal', theme),
                    const SizedBox(height: 16),
                    SettingsGroupContainer(
                      children: [
                        SettingsListTile(
                          icon: Icons.policy_outlined,
                          title: 'Privacy & Legal',
                          subtitle: 'Privacy Policy, Terms of Service',
                          iconColor: colorScheme.tertiary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout),
                      label: const Text('Sign Out of Account'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFBA1A1A),
                        side: const BorderSide(color: Color(0x33BA1A1A)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'VERSION 2.4.0 (GOLD)',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w600,
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

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.grey[500],
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}