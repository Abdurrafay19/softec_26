import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme_provider.dart';
import '../widgets/settings_group_container.dart';

class ThemeSelectionScreen extends ConsumerWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final selectedTheme = ref.watch(themeProvider);

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
            SettingsGroupContainer(
              children: [
                _buildThemeRadio(
                  context: context,
                  ref: ref,
                  title: 'System Default',
                  subtitle: 'Adapts to your device settings',
                  icon: Icons.brightness_auto_outlined,
                  value: ThemeMode.system,
                  groupValue: selectedTheme,
                  iconColor: colorScheme.primary,
                ),
                _buildThemeRadio(
                  context: context,
                  ref: ref,
                  title: 'Light Theme',
                  subtitle: 'Crisp white and soft grays',
                  icon: Icons.light_mode_outlined,
                  value: ThemeMode.light,
                  groupValue: selectedTheme,
                  iconColor: colorScheme.secondary,
                ),
                _buildThemeRadio(
                  context: context,
                  ref: ref,
                  title: 'Dark Theme',
                  subtitle: 'Deep charcoal and muted blues',
                  icon: Icons.dark_mode_outlined,
                  value: ThemeMode.dark,
                  groupValue: selectedTheme,
                  iconColor: colorScheme.tertiary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeRadio({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required String subtitle,
    required IconData icon,
    required ThemeMode value,
    required ThemeMode groupValue,
    required Color iconColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          ref.read(themeProvider.notifier).state = value;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Row(
            children: [
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
              Radio<ThemeMode>(
                value: value,
                groupValue: groupValue,
                activeColor: colorScheme.primary,
                onChanged: (ThemeMode? newValue) {
                  if (newValue != null) {
                    ref.read(themeProvider.notifier).state = newValue;
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
