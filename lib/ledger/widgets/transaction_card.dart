import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// An enum makes handling our specific status styles much cleaner
enum TransactionStatus { completed, received, declined }

class TransactionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String date;
  final double amount;
  final TransactionStatus status;
  final Color? iconThemeColor;

  const TransactionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
    this.iconThemeColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // --- 1. Dynamic Logic for Amounts & States ---
    final bool isIncome = amount >= 0;

    // Amount Color: Income is Secondary (Cyan/Green), others are default text color
    Color amountColor = colorScheme.onSurface;
    if (isIncome && status != TransactionStatus.declined) {
      amountColor = colorScheme.secondary;
    }

    // Status Pill Colors
    Color pillBgColor;
    Color pillTextColor;

    switch (status) {
      case TransactionStatus.declined:
        pillBgColor = colorScheme.errorContainer;
        pillTextColor = colorScheme.onErrorContainer;
        break;
      case TransactionStatus.received:
      // Use a 20% tint of the secondary color for a soft glass look
        pillBgColor = colorScheme.secondaryContainer.withValues(alpha: 0.3);
        pillTextColor = colorScheme.onSecondaryContainer;
        break;
      case TransactionStatus.completed:
      // Neutral pill for standard transactions
        pillBgColor = colorScheme.surfaceContainerHighest;
        pillTextColor = colorScheme.onSurfaceVariant;
    }

    // Format the number string securely
    final formattedAmount = '\$${amount.abs().toStringAsFixed(2)}';
    final amountPrefix = isIncome ? '+' : '-';

    // --- 2. Build the Card ---
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest, // Crisp white / Dark charcoal
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          // The signature 4% ambient shadow
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Left Side: Icon & Titles ---
          Expanded(
            child: Row(
              children: [
                // Soft Icon Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (iconThemeColor ?? colorScheme.primary).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: iconThemeColor ?? colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),

                // Text Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.outline,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // --- Right Side: Amount & Status Pill ---
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$amountPrefix$formattedAmount',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: amountColor,
                  // The magic line that aligns all decimals perfectly in a list!
                  fontFeatures: const [FontFeature.tabularFigures()],
                  letterSpacing: -0.5, // Slight tuck for numbers makes them look premium
                ),
              ),
              const SizedBox(height: 6),

              // Status Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: pillBgColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  status.name.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: pillTextColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}