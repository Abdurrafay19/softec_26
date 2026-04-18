import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Added for editorial typography

// Modular Auth Widgets
import '../widgets/auth_header.dart';
import '../../shared/widgets/editorial_text_field.dart';
import '../../shared/widgets/primary_button.dart';
import '../widgets/biometric_action_button.dart';
// import '../widgets/auth_footer.dart';
import 'signup_screen.dart';
import '../../navigation/screens/main_navigation_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the global theme tokens exactly like HomeScreen
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      // Utilizing theme surface token instead of hardcoded Color(0xFFF7F9FF)
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
                        color: colorScheme.primary, // Tied to primary theme color
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      'Enter your credentials to access your financial sanctuary.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Main Login Card
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        // Replaced Colors.white with the dynamic surface token
                        color: colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(24),
                        // Ambient shadow adapting to the dynamic onSurface color
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
                          const EditorialTextField(
                            label: 'Email Address',
                            hintText: 'name@company.com',
                            helperText: 'Use your registered business email',
                          ),
                          const SizedBox(height: 24),

                          EditorialTextField(
                            label: 'Password',
                            hintText: '••••••••',
                            isPassword: true,
                            trailingLabelAction: GestureDetector(
                              onTap: () {
                                // TODO: Handle forgot password
                              },
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          PrimaryButton(
                            text: 'Sign In',
                            icon: Icons.login,
                            onPressed: () {
                              // Use pushReplacement so the user cannot pop back to the login screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
                              );
                            },
                          ),
                          const SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  'OR',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    color: colorScheme.outline,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          BiometricActionButton(
                              onPressed: () {
                                // TODO: Trigger FaceID/Fingerprint check
                              }
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: GoogleFonts.inter(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const SignupScreen()),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: colorScheme.primary,
                            textStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),

                    const Spacer(),
                    // const AuthFooter(),
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