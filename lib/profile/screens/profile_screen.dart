import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/settings_group_container.dart';
import '../widgets/settings_tile.dart';
import '../screens/theme_selection_screen.dart';
import '../../core/database/hive_service.dart';
import '../../ledger/transaction_provider.dart';
import 'edit_profile_screen.dart';
import 'terms_conditions_screen.dart';
import '../../auth/screens/signup_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
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
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSectionTitle('Account Configuration', colorScheme),
                    const SizedBox(height: 16),
                    SettingsGroupContainer(
                      children: [
                        SettingsListTile(
                          icon: Icons.business_center_outlined,
                          title: 'Edit Profile',
                          subtitle: 'Update your display name',
                          iconColor: colorScheme.primary,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ),
                            );
                          },
                        ),
                        SettingsListTile(
                          icon: Icons.upload_file_outlined,
                          title: 'Export Backup',
                          subtitle: 'Save your data to a JSON file',
                          iconColor: colorScheme.primary,
                          onTap: () async {
                            try {
                              await HiveService.exportBackup();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Backup exported successfully')),
                                );
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Export failed: $e')),
                                );
                              }
                            }
                          },
                        ),
                        SettingsListTile(
                          icon: Icons.file_download_outlined,
                          title: 'Import Backup',
                          subtitle: 'Restore your data from a JSON file',
                          iconColor: colorScheme.primary,
                          onTap: () async {
                            final bool? confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Import Backup?'),
                                content: const Text('This will replace all your current transactions and goals. This action cannot be undone.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, true),
                                    child: const Text('Import'),
                                  ),
                                ],
                              ),
                            );

                            if (confirm != true) return;

                            try {
                              final imported = await HiveService.importBackup();
                              if (imported && context.mounted) {
                                ref.invalidate(transactionsProvider);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Backup imported successfully')),
                                );
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Import failed: $e')),
                                );
                              }
                            }
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
                            activeThumbColor: colorScheme.primary,
                          ),
                        ),
                        SettingsListTile(
                          icon: Icons.palette_outlined,
                          title: 'Visual Appearance',
                          subtitle: 'Customize app colors',
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
                                  color: Color(0xFF555555),
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

                    Center(
                      child: Text(
                        'VERSION 2.4.0 (GOLD)',
                        style: GoogleFonts.inter(
                          color: colorScheme.outline,
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

  Widget _buildSectionTitle(String title, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: colorScheme.outline,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
