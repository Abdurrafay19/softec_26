import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Assuming you have this widget available based on your previous code
import '../widgets/settings_group_container.dart';

class ThemeSelectionScreen extends StatefulWidget {
  const ThemeSelectionScreen({super.key});

  @override
  State<ThemeSelectionScreen> createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen> {
  // This state determines which radio is currently selected.
  // Note: To make the theme actually change app-wide, you will need to tie this
  // to your state management solution (Provider, Riverpod, BLoC, etc.) and update
  // the themeMode property in your main.dart MaterialApp.
  ThemeMode _selectedTheme = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        title: Text(
          'Visual Appearance',
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
              child: Text(
                'THEME PREFERENCE',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: colorScheme.outline,
                  letterSpacing: 1.5,
                ),
              ),
            ),

            // Using your container to maintain the "No-Line" stacked paper look
            SettingsGroupContainer(
              children: [
                _buildThemeRadio(
                  context: context,
                  title: 'System Default',
                  subtitle: 'Adapts to your device settings',
                  icon: Icons.brightness_auto_outlined,
                  value: ThemeMode.system,
                  iconColor: colorScheme.primary,
                ),
                _buildThemeRadio(
                  context: context,
                  title: 'Light Theme',
                  subtitle: 'Crisp white and soft grays',
                  icon: Icons.light_mode_outlined,
                  value: ThemeMode.light,
                  iconColor: colorScheme.secondary,
                ),
                _buildThemeRadio(
                  context: context,
                  title: 'Dark Theme',
                  subtitle: 'Deep charcoal and muted blues',
                  icon: Icons.dark_mode_outlined,
                  value: ThemeMode.dark,
                  iconColor: colorScheme.tertiary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // A custom builder for the radio rows to match your SettingsListTile aesthetic
  Widget _buildThemeRadio({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required ThemeMode value,
    required Color iconColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = _selectedTheme == value;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTheme = value;
          });
          // TODO: Dispatch state update to your global theme manager here
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Row(
            children: [
              // Tinted Icon Box
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 16),

              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // The active radio indicator
              Radio<ThemeMode>(
                value: value,
                groupValue: _selectedTheme,
                activeColor: colorScheme.primary, // Dynamically matches Material You
                onChanged: (ThemeMode? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedTheme = newValue;
                    });
                    // TODO: Dispatch state update to your global theme manager here
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}