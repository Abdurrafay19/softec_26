import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add 'intl: ^0.19.0' to your pubspec.yaml for date formatting
import '../models/transaction.dart';
import '../widgets/add_record_sheet.dart';
import '../widgets/pipeline_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isAILoading = false;

  // Phase 1: Dynamic Data State
  final List<Transaction> _recentActivity = [
    Transaction(id: '1', name: 'Supplier Payment', date: DateTime.now().subtract(const Duration(days: 1)), amount: -1250.00, icon: Icons.shopping_cart, isPending: true),
    Transaction(id: '2', name: 'Client Invoice #402', date: DateTime.now().subtract(const Duration(days: 2)), amount: 4500.00, icon: Icons.account_balance_wallet, isPending: true),
    Transaction(id: '3', name: 'Office Rent', date: DateTime.now().subtract(const Duration(days: 4)), amount: -2200.00, icon: Icons.business),
  ];

  // Phase 1: Dynamic Getters
  double get cashOnHand => _recentActivity
      .where((t) => !t.isPending) // Only completed transactions count toward cash on hand
      .fold(0, (sum, item) => sum + item.amount);

  double get pendingReceivables => _recentActivity
      .where((t) => t.isPending && t.amount > 0)
      .fold(0, (sum, item) => sum + item.amount);

  double get pendingPayables => _recentActivity
      .where((t) => t.isPending && t.amount < 0)
      .fold(0, (sum, item) => sum + item.amount);

  String formatCurrency(double amount) {
    return '\$${amount.abs().toStringAsFixed(0).replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',')}';
  }

  // Phase 3: Add Record Logic
  void _addNewTransaction(Transaction tx) {
    setState(() {
      _recentActivity.insert(0, tx);
    });
  }

  // Phase 4: Delete Record Logic
  void _removeTransaction(int index) {
    final deletedItem = _recentActivity[index];
    setState(() {
      _recentActivity.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${deletedItem.name} deleted'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _recentActivity.insert(index, deletedItem);
            });
          },
        ),
      ),
    );
  }

  // Phase 5: The "Wow Factor" AI Insight
  Future<void> _generateAIInsight() async {
    setState(() => _isAILoading = true);

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isAILoading = false);

    // Dynamic insight based on calculated data
    String insight;
    if (pendingPayables.abs() > (cashOnHand * 0.5)) {
      insight = "Warning: Your pending payables are exceeding 50% of your cash on hand.";
    } else {
      insight = "Insight: Cash flow is stable. Prioritize collecting your ${formatCurrency(pendingReceivables)} in receivables.";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(insight),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dateFormatter = DateFormat('MMM d, yyyy');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Cash Flow'),
        actions: [
          // AI Insight Button
          IconButton(
            icon: _isAILoading
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.auto_awesome),
            onPressed: _isAILoading ? null : _generateAIInsight,
            tooltip: 'Generate Financial Insight',
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0, left: 8.0),
            child: CircleAvatar(child: Icon(Icons.person_outline)),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Snapshot
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 0,
                color: colorScheme.primaryContainer.withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        'Cash on Hand',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            formatCurrency(cashOnHand),
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            cashOnHand >= 0 ? Icons.trending_up : Icons.trending_down,
                            color: cashOnHand >= 0 ? Colors.green.shade700 : Colors.red.shade700,
                            size: 28,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Pipeline Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: PipelineCard(
                    label: 'Pending Receivables',
                    amount: formatCurrency(pendingReceivables),
                    amountColor: Colors.green.shade700,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PipelineCard(
                    label: 'Pending Payables',
                    amount: formatCurrency(pendingPayables),
                    amountColor: Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Recent Activity',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),

          // Ledger List with Dismissible
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _recentActivity.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final tx = _recentActivity[index];
                final isPositive = tx.amount > 0;

                return Dismissible(
                  key: Key(tx.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) => _removeTransaction(index),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      child: Icon(tx.icon, color: colorScheme.primary, size: 20),
                    ),
                    title: Row(
                      children: [
                        Text(tx.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                        if (tx.isPending) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Pending',
                              style: TextStyle(fontSize: 10, color: colorScheme.onSecondaryContainer),
                            ),
                          ),
                        ]
                      ],
                    ),
                    subtitle: Text(dateFormatter.format(tx.date)),
                    trailing: Text(
                      '${isPositive ? "+" : "-"}${formatCurrency(tx.amount)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isPositive ? Colors.green.shade700 : Colors.red.shade700,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Needed for keyboard to not cover form
            builder: (context) => AddRecordSheet(onSave: _addNewTransaction),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Record'),
      ),
    );
  }
}