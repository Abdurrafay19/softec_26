import 'package:flutter/material.dart';
import '../models/ai_model.dart';
import '../services/ai_services.dart';

class AIGuidanceCard extends StatelessWidget {
  const AIGuidanceCard({super.key});

  void _showAIGuide(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _AIGuideBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: colorScheme.onPrimary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'AI Financial Strategist',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Analyze your recent cash flow data to generate an instant, text-based strategy. Get personalized guidance on optimizing your daily usage budget, managing your burn-rate, and accelerating your business milestones.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => _showAIGuide(context),
              icon: const Icon(Icons.analytics_outlined),
              label: const Text(
                'Generate Strategy Guide',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------
// Stateful Bottom Sheet (Handles API calls and UI states)
// ----------------------------------------------------------------------

class _AIGuideBottomSheet extends StatefulWidget {
  const _AIGuideBottomSheet();

  @override
  State<_AIGuideBottomSheet> createState() => _AIGuideBottomSheetState();
}

class _AIGuideBottomSheetState extends State<_AIGuideBottomSheet> {
  final AIService _aiService = AIService();
  late Future<AIStrategyGuide> _strategyFuture;

  @override
  void initState() {
    super.initState();
    // Trigger the API call as soon as the sheet opens
    // Note: Pass actual variables from your state management here
    _strategyFuture = _aiService.generateFinancialStrategy(
      userId: 'user_123',
      currentBalance: 10300.00,
      monthlyBurnRate: 14200.00,
    );
  }

  // Helper to map category strings from your backend to specific UI icons/colors
  (IconData, Color) _getCategoryStyle(String category) {
    switch (category.toLowerCase()) {
      case 'budget':
        return (Icons.account_balance_wallet_rounded, Colors.blue.shade600);
      case 'burn_rate':
        return (Icons.local_fire_department_rounded, Colors.orange.shade600);
      case 'goal':
        return (Icons.flag_circle_rounded, Colors.green.shade600);
      default:
        return (Icons.lightbulb_outline_rounded, Colors.purple.shade600);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 32),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
        minHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your AI Strategy Guide',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 24),

          // FutureBuilder to handle Loading, Error, and Success states
          Expanded(
            child: FutureBuilder<AIStrategyGuide>(
              future: _strategyFuture,
              builder: (context, snapshot) {
                
                // --- 1. LOADING STATE ---
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: colorScheme.primary),
                      const SizedBox(height: 24),
                      Text(
                        'Analyzing your ledger...\nGenerating insights...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                    ],
                  );
                }

                // --- 2. ERROR STATE ---
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Unable to generate strategy right now.\nPlease try again later.\n\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colorScheme.error),
                    ),
                  );
                }

                // --- 3. SUCCESS STATE ---
                final strategy = snapshot.data!;
                return ListView(
                  children: [
                    Text(
                      strategy.summary,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Generate cards dynamically from the API response
                    ...strategy.sections.map((section) {
                      final style = _getCategoryStyle(section.category);
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: _buildAdviceSection(
                          context: context,
                          icon: style.$1,
                          iconColor: style.$2,
                          title: section.title,
                          content: section.content,
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceSection({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}