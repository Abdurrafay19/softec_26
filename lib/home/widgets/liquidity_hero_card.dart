import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../ledger/transaction_provider.dart';

class LiquidityHeroCard extends ConsumerWidget {
  const LiquidityHeroCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch totalBalance and percentChange from the summary
    final summary = ref.watch(transactionsProvider);
    final totalBalance = summary.totalBalance;
    final percentChange = summary.percentChange;
    
    final colorScheme = Theme.of(context).colorScheme;
    final formatter = NumberFormat.currency(symbol: r'$', decimalDigits: 2);
    
    final bool isPositive = percentChange >= 0;
    final Color trendColor = isPositive ? Colors.green : Colors.red;
    final IconData trendIcon = isPositive ? Icons.trending_up : Icons.trending_down;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.04),
            blurRadius: 40,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AVAILABLE BALANCE',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              formatter.format(totalBalance),
              style: GoogleFonts.manrope(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                letterSpacing: -2.0,
                color: colorScheme.onSurface,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: trendColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      trendIcon,
                      color: trendColor.withValues(alpha: 0.8),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${isPositive ? '+' : ''}${percentChange.toStringAsFixed(1)}%',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: trendColor.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'vs last month',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
