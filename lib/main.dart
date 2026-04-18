// lib/main.dart

import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'navigation/screens/main_navigation_screen.dart';

void main() {
  runApp(const FiscalArchitectApp());
}

class FiscalArchitectApp extends StatelessWidget {
  const FiscalArchitectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Fiscal Architect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigationScreen(),
    );
  }
}