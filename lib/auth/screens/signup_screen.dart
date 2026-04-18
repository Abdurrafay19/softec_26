import 'package:flutter/material.dart';
import '../widgets/auth_header.dart';
import '../../shared/widgets/editorial_text_field.dart';
import '../../shared/widgets/primary_button.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
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
                      'Create Your Sanctuary',
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1.0,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Set up your secure business profile.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 40),
                    
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(24, 28, 32, 0.06),
                            offset: Offset(0, 24),
                            blurRadius: 40,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const EditorialTextField(
                            label: 'Full Name',
                            hintText: 'e.g., Elena Richardson',
                          ),
                          const SizedBox(height: 24),
                          const EditorialTextField(
                            label: 'Company Name',
                            hintText: 'e.g., Lumen Creative Agency',
                          ),
                          const SizedBox(height: 24),
                          const EditorialTextField(
                            label: 'Business Email',
                            hintText: 'name@company.com',
                          ),
                          const SizedBox(height: 24),
                          const EditorialTextField(
                            label: 'Password',
                            hintText: '••••••••',
                            isPassword: true,
                          ),
                          const SizedBox(height: 40),
                          PrimaryButton(
                            text: 'Create Account',
                            icon: Icons.person_add,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
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