import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sme_cash_flow_dashboard/auth/screens/signup_screen.dart';
import 'core/app_theme.dart';
import 'core/database/hive_service.dart';
import 'core/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await HiveService.init();

  
  // Wrap the entire app in ProviderScope for Riverpod
  runApp(
    const ProviderScope(
      child: FiscalArchitectApp(),
    ),
  );
}

class FiscalArchitectApp extends ConsumerWidget {
  const FiscalArchitectApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the themeProvider to react to changes
    final themeMode = ref.watch(themeProvider);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'The Fiscal Architect',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(lightDynamic),
          darkTheme: AppTheme.darkTheme(darkDynamic),
          themeMode: themeMode,
          home: const SignupScreen(),
        );
      },
    );
  }
}
