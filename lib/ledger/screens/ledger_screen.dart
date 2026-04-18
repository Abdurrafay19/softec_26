import 'package:flutter/material.dart';

// Import your beautiful modular widgets
import '../widgets/ledger_search_bar.dart';
import '../widgets/filter_chip_row.dart';
import '../widgets/transaction_group_header.dart';
import '../widgets/transaction_card.dart';






class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  int _selectedFilterIndex = 0;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  static const List<_TransactionData> _recentTransactions = [
    _TransactionData(
      icon: Icons.cloud,
      title: 'Amazon Web Services',
      date: 'May 24, 2024 • Cloud Infrastructure',
      amount: -1240.50,
      status: TransactionStatus.completed,
    ),
    _TransactionData(
      icon: Icons.payments,
      title: 'Client Deposit: Nova Corp',
      date: 'May 23, 2024 • Invoice #8821',
      amount: 5500.00,
      status: TransactionStatus.received,
    ),
    _TransactionData(
      icon: Icons.design_services,
      title: 'Figma Subscription',
      date: 'May 22, 2024 • Software & Tools',
      amount: -45.00,
      status: TransactionStatus.completed,
    ),
    _TransactionData(
      icon: Icons.restaurant,
      title: 'The Daily Grind Cafe',
      date: 'May 20, 2024 • Meals & Entertainment',
      amount: -32.40,
      status: TransactionStatus.completed,
    ),
    _TransactionData(
      icon: Icons.history,
      title: 'Apple Store Refund',
      date: 'May 18, 2024 • Hardware Return',
      amount: 199.00,
      status: TransactionStatus.completed,
    ),
    _TransactionData(
      icon: Icons.warning_rounded,
      title: 'Office Rent Auto-Pay',
      date: 'May 15, 2024 • Facilities',
      amount: -2850.00,
      status: TransactionStatus.declined,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _matchesSearch(_TransactionData transaction) {
    if (_searchQuery.isEmpty) {
      return true;
    }

    final query = _searchQuery.toLowerCase();
    final amountText = transaction.amount.abs().toStringAsFixed(2);

    return transaction.title.toLowerCase().contains(query) ||
        transaction.date.toLowerCase().contains(query) ||
        amountText.contains(query);
  }

  List<_TransactionData> _applyFilter(List<_TransactionData> transactions) {
    switch (_selectedFilterIndex) {
      case 1:
        return transactions.where((transaction) => transaction.amount > 0).toList();
      case 2:
        return transactions.where((transaction) => transaction.amount < 0).toList();
      default:
        return transactions;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = _applyFilter(_recentTransactions)
        .where(_matchesSearch)
        .toList();
    final List<Widget> transactionCards = filteredTransactions
        .expand<Widget>(
          (transaction) => [
            TransactionCard(
              icon: transaction.icon,
              title: transaction.title,
              date: transaction.date,
              amount: transaction.amount,
              status: transaction.status,
            ),
            const SizedBox(height: 12),
          ],
        )
        .toList();

    if (transactionCards.isNotEmpty) {
      transactionCards.removeLast();
    }

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

        children: [
          LedgerSearchBar(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          const SizedBox(height: 24),

          FilterChipRow(
            selectedIndex: _selectedFilterIndex,
            onSelected: (index) => setState(() => _selectedFilterIndex = index),
          ),
          const SizedBox(height: 40), // Extra space before the data starts

          // --- Group 1: Recent Transactions ---
          const TransactionGroupHeader(title: 'Recent Transactions'),
          ...transactionCards,
        ],
      ),
    );
  }
}

class _TransactionData {
  const _TransactionData({
    required this.icon,
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
  });

  final IconData icon;
  final String title;
  final String date;
  final double amount;
  final TransactionStatus status;
}