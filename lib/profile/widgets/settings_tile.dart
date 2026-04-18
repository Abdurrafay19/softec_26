import 'package:flutter/material.dart';

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
    // We use Material and InkWell to handle the hover/tap background shifts 
    // without relying on harsh divider lines.
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        // Optional: you can set the hoverColor here to match your 'surface-container-low' token
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Matches the p-5 from the HTML
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. The 40x40 Tinted Icon Container
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.10), // 10% opacity background
                  borderRadius: BorderRadius.circular(12), // rounded-xl equivalent
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20, // Adjusted for the 40x40 box
                ),
              ),
              
              const SizedBox(width: 16), // gap-4 equivalent
              
              // 2. The Text Column (Title & Subtitle)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                    color: const Color(0xFFC1C6D6),
                  ),  
            ],
          ),
        ),
      ),
    );
  }
}