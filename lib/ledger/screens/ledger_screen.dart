import 'package:flutter/material.dart';

// Import your beautiful modular widgets
import '../widgets/ledger_search_bar.dart';
import '../widgets/filter_chip_row.dart';
import '../widgets/transaction_group_header.dart';
import '../widgets/transaction_card.dart';

class LedgerScreen extends StatelessWidget {
  const LedgerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Crucial: Keeps the background transparent so the app background bleeds through
      backgroundColor: Colors.transparent,

      body: ListView(
        // The Magic Padding:
        // 120px top to clear the frosted AppBar
        // 120px bottom to clear the frosted BottomNav
        // 24px sides for that extreme breathing room
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 120),

        // Hides the default scrollbar to keep the UI perfectly clean
        physics: const BouncingScrollPhysics(),

        children: const [
          LedgerSearchBar(),
          SizedBox(height: 24),

          FilterChipRow(),
          SizedBox(height: 40), // Extra space before the data starts

          // --- Group 1: Recent Transactions ---
          TransactionGroupHeader(title: 'Recent Transactions'),
          TransactionCard(
            icon: Icons.cloud,
            title: 'Amazon Web Services',
            date: 'May 24, 2024 • Cloud Infrastructure',
            amount: -1240.50,
            status: TransactionStatus.completed,
          ),
          SizedBox(height: 12),
          TransactionCard(
            icon: Icons.payments,
            title: 'Client Deposit: Nova Corp',
            date: 'May 23, 2024 • Invoice #8821',
            amount: 5500.00,
            status: TransactionStatus.received,
          ),
          SizedBox(height: 12),
          TransactionCard(
            icon: Icons.design_services,
            title: 'Figma Subscription',
            date: 'May 22, 2024 • Software & Tools',
            amount: -45.00,
            status: TransactionStatus.completed,
          ),
          SizedBox(height: 12), // Breathing room between date groupings
          TransactionCard(
            icon: Icons.restaurant,
            title: 'The Daily Grind Cafe',
            date: 'May 20, 2024 • Meals & Entertainment',
            amount: -32.40,
            status: TransactionStatus.completed,
          ),
          SizedBox(height: 12),
          TransactionCard(
            icon: Icons.history,
            title: 'Apple Store Refund',
            date: 'May 18, 2024 • Hardware Return',
            amount: 199.00,
            status: TransactionStatus.completed,
          ),
          SizedBox(height: 12),
          TransactionCard(
            icon: Icons.warning_rounded,
            title: 'Office Rent Auto-Pay',
            date: 'May 15, 2024 • Facilities',
            amount: -2850.00,
            status: TransactionStatus.declined,
          ),
        ],
      ),
    );
  }
}