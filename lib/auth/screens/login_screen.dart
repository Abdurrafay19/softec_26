import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart'; // Added for local authentication

// Modular Auth Widgets
import '../widgets/auth_header.dart';
import '../../shared/widgets/primary_button.dart';
import '../../navigation/screens/main_navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticating = false;

  Future<void> _authenticate() async {
    setState(() => _isAuthenticating = true);

    try {
      // Trigger the OS-level Biometric / PIN dialog
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access your financial sanctuary.',
          biometricOnly: false, // Set to false to allow device PIN fallback
      );

      if (didAuthenticate && mounted) {
        // Success: Navigate to the main app
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Authentication Error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isAuthenticating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 32.0, bottom: 16.0),
                child: AuthHeader(),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const Spacer(),

                    Text(
                      'Welcome Back',
                      style: GoogleFonts.manrope(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1.0,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      'Verify your identity to unlock your ledger.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Centered Local Auth Card
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.onSurface.withValues(alpha: 0.06),
                            offset: const Offset(0, 24),
                            blurRadius: 40,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Visual Icon for Biometrics
                          // Icon(
                          //   Icons.login, // Consider updating this to a fingerprint or face icon later
                          //   size: 60,
                          //   color: colorScheme.primary.withValues(alpha: 0.8),
                          // ),
                          // const SizedBox(height: 32),

                          _isAuthenticating
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: colorScheme.primary,
                                  ),
                                )
                              : PrimaryButton(
                                  text: 'Unlock App',
                                  icon: Icons.lock_open,
                                  onPressed: _authenticate,
                                ),
                        ],
                      ),
                    ),

                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}