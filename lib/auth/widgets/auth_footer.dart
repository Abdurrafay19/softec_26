import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final linkStyle = theme.textTheme.bodySmall?.copyWith(
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
      child: Column(
        children: [
          Text(
            '© 2024 The Fiscal Architect. Secure B2B Financial Systems.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF001A41), 
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 8,
            children: [
              GestureDetector(onTap: () {}, child: Text('Privacy Policy', style: linkStyle)),
              GestureDetector(onTap: () {}, child: Text('Terms of Service', style: linkStyle)),
              GestureDetector(onTap: () {}, child: Text('Security Architecture', style: linkStyle)),
            ],
          ),
        ],
      ),
    );
  }
}