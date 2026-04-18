import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../transaction_provider.dart';
import '../widgets/ledger_search_bar.dart';
import '../widgets/filter_chip_row.dart';
import '../widgets/transaction_group_header.dart';
import '../widgets/transaction_card.dart';

class LedgerScreen extends ConsumerStatefulWidget {
  const LedgerScreen({super.key});

  @override
  ConsumerState<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends ConsumerState<LedgerScreen> {
  int _selectedFilterIndex = 0;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Food': return Icons.restaurant;
      case 'Bills': return Icons.receipt_long;
      case 'Shopping': return Icons.shopping_bag;
      case 'Transport': return Icons.directions_car;
      case 'Entertainment': return Icons.movie;
      case 'Health': return Icons.medical_services;
      case 'Business': return Icons.business_center;
      case 'Income': return Icons.payments;
      default: return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the summary instead of the list
    final summary = ref.watch(transactionsProvider);
    final transactions = summary.transactions;

    // Apply Search Filter
    final filteredBySearch = transactions.where((tx) {
      if (_searchQuery.isEmpty) return true;
      final query = _searchQuery.toLowerCase();
      return tx.name.toLowerCase().contains(query) || 
             tx.category.toLowerCase().contains(query) ||
             tx.description.toLowerCase().contains(query);
    }).toList();

    // Apply Tab Filter (All, In, Out)
    final filteredTransactions = filteredBySearch.where((tx) {
      if (_selectedFilterIndex == 1) return tx.isMoneyIn;
      if (_selectedFilterIndex == 2) return !tx.isMoneyIn;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 120),
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
          const SizedBox(height: 40),

          if (filteredTransactions.isEmpty)
             Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  'No transactions found.',
                  style: TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
              ),
            )
          else ...[
            const TransactionGroupHeader(title: 'Activity'),
            ...filteredTransactions.map((tx) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: TransactionCard(
                icon: _getIconForCategory(tx.category),
                title: tx.name,
                date: '${DateFormat('MMM dd, yyyy').format(tx.date)} • ${tx.category}',
                amount: tx.isMoneyIn ? tx.amount : -tx.amount,
                status: TransactionStatus.completed, 
              ),
            )),
          ],
        ],
      ),
    );
  }
}
