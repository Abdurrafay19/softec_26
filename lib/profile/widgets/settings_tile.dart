import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Added for editorial typography

class SettingsListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Access the global theme tokens
    final colorScheme = Theme.of(context).colorScheme;

    // We use Material and InkWell to handle the hover/tap background shifts
    // without relying on harsh divider lines.
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        // Match the hover state to the soft surface hierarchy
        hoverColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. The 40x40 Tinted Icon Container
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),

              const SizedBox(width: 16),

              // 2. The Text Column (Title & Subtitle)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface, // Adapts to Light/Dark Mode
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant, // Muted secondary text
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // 3. The Trailing Widget (Custom switch or default chevron)
              trailing ??
                  Icon(
                    Icons.chevron_right,
                    // Swapped hardcoded hex for dynamic outlineVariant
                    color: colorScheme.outlineVariant,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}