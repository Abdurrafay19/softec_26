import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketra/auth/screens/signup_screen.dart';
import 'package:pocketra/auth/screens/login_screen.dart';
import 'package:pocketra/navigation/screens/main_navigation_screen.dart';
import 'package:pocketra/shared/screens/splash_screen.dart';
import 'core/app_theme.dart';
import 'core/database/hive_service.dart';
import 'core/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  runApp(const ProviderScope(child: FiscalArchitectApp()));
}

class FiscalArchitectApp extends ConsumerStatefulWidget {
  const FiscalArchitectApp({super.key});

  @override
  ConsumerState<FiscalArchitectApp> createState() => _FiscalArchitectAppState();
}

class _FiscalArchitectAppState extends ConsumerState<FiscalArchitectApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _resolveHome() {
    final bool hasCompletedSignup = HiveService.isSignupCompleted();
    final bool biometricsEnabled = HiveService.isBiometricsEnabled();

    if (!hasCompletedSignup) {
      return const SignupScreen();
    }

    if (biometricsEnabled) {
      return const LoginScreen();
    }

    return const MainNavigationScreen();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'Pocketra',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(lightDynamic),
          darkTheme: AppTheme.darkTheme(darkDynamic),
          themeMode: themeMode,
          home: _isLoading ? const SplashScreen() : _resolveHome(),
        );
      },
    );
  }
}



//// Team Name: Alpha Devs

