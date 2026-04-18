import 'package:dynamic_color/dynamic_color.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:sme_cash_flow_dashboard/auth/screens/login_screen.dart';
import 'package:sme_cash_flow_dashboard/auth/screens/signup_screen.dart';
import 'core/app_theme.dart';
//import 'navigation/screens/main_navigation_screen.dart';



void main() {
  runApp(const FiscalArchitectApp());
}

class FiscalArchitectApp extends StatelessWidget {
  const FiscalArchitectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'The Fiscal Architect',
          debugShowCheckedModeBanner: false,
          // Use dynamic colors if available, otherwise fall back to your custom theme
          theme: AppTheme.lightTheme(lightDynamic),
          darkTheme: AppTheme.darkTheme(darkDynamic),
          themeMode: ThemeMode.system,
          // home: const MainNavigationScreen(),
          home: SignupScreen(),
        );
      },
    );
  }
}