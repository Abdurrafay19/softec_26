import 'package:flutter/material.dart';

class SettingsGroupContainer extends StatelessWidget {
  final List<Widget> children;

  const SettingsGroupContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        // Adapts seamlessly to Light/Dark mode instead of blinding white
        color: colorScheme.surfaceContainerLowest,
        // Increased to 24 to match the premium 'xl' rounding rule
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          // Dynamic ambient shadow
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.04),
            offset: const Offset(0, 4),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    );
  }
}