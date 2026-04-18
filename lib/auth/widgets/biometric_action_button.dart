import 'package:flutter/material.dart';

class BiometricActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BiometricActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.fingerprint, color: theme.colorScheme.primary),
      label: Text(
        'Biometric Login',
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withOpacity(0.2),
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}