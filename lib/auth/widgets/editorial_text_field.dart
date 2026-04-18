import 'package:flutter/material.dart';

class EditorialTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? helperText;
  final bool isPassword;
  final Widget? trailingLabelAction;

  const EditorialTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.helperText,
    this.isPassword = false,
    this.trailingLabelAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
              child: Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
            if (trailingLabelAction != null) trailingLabelAction!,
          ],
        ),
        TextFormField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: theme.colorScheme.outline),
            filled: true,
            fillColor: const Color(0xFFE5E8EE), 
            contentPadding: const EdgeInsets.all(16),
            border: const UnderlineInputBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
            ),
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              helperText!,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ],
    );
  }
}