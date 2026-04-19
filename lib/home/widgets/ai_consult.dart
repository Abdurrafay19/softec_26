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
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: colorScheme.onPrimaryContainer,
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
            'Analyze your recent cash flow data to generate an instant, text-based strategy. Get personalized guidance on optimizing your daily usage budget and managing your burn-rate.',
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
    _strategyFuture = _aiService.generateFinancialStrategy(
      userId: 'user_123',
      currentBalance: 10300.00,
      monthlyBurnRate: 14200.00,
    );
  }

  (IconData, Color) _getCategoryStyle(BuildContext context, String category) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (category.toLowerCase()) {
      case 'budget':
        return (Icons.account_balance_wallet_rounded, colorScheme.primary);
      case 'burn_rate':
        return (Icons.local_fire_department_rounded, colorScheme.error);
      case 'goal':
        return (Icons.flag_circle_rounded, colorScheme.tertiary);
      default:
        return (Icons.lightbulb_outline_rounded, colorScheme.secondary);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
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
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
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

          Expanded(
            child: FutureBuilder<AIStrategyGuide>(
              future: _strategyFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: colorScheme.primary),
                      const SizedBox(height: 24),
                      Text(
                        'Analyzing your pocket ledger...\nGenerating insights...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                    ],
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Unable to generate strategy right now.\nPlease try again later.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colorScheme.error),
                    ),
                  );
                }

                final strategy = snapshot.data!;
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Text(
                      strategy.summary,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    ...strategy.sections.map((section) {
                      final style = _getCategoryStyle(context, section.category);
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
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
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
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
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
