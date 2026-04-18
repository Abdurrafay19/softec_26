import 'package:flutter/material.dart';

class SettingsGroupContainer extends StatelessWidget {
  final List<Widget> children;

  const SettingsGroupContainer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12), 
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(24, 28, 32, 0.04), 
            offset: Offset(0, 4),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
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