import 'package:flutter/material.dart';

void main() {
  runApp(const SmeCashFlowApp());
}

class SmeCashFlowApp extends StatelessWidget {
  const SmeCashFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SME Cash Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class Transaction {
  final String name;
  final String date;
  final double amount;
  final IconData icon;

  const Transaction({
    required this.name,
    required this.date,
    required this.amount,
    required this.icon,
  });
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Dummy data for the prototype
  final List<Transaction> _recentActivity = [
    const Transaction(
      name: 'Supplier Payment',
      date: 'Oct 24, 2023',
      amount: -1250.00,
      icon: Icons.shopping_cart,
    ),
    const Transaction(
      name: 'Client Invoice #402',
      date: 'Oct 23, 2023',
      amount: 4500.00,
      icon: Icons.account_balance_wallet,
    ),
    const Transaction(
      name: 'Office Rent',
      date: 'Oct 20, 2023',
      amount: -2200.00,
      icon: Icons.business,
    ),
    const Transaction(
      name: 'Consulting Fee',
      date: 'Oct 18, 2023',
      amount: 1200.00,
      icon: Icons.person,
    ),
    const Transaction(
      name: 'Software Subscription',
      date: 'Oct 15, 2023',
      amount: -49.99,
      icon: Icons.computer,
    ),
    const Transaction(
      name: 'Refund: Material Error',
      date: 'Oct 12, 2023',
      amount: 320.00,
      icon: Icons.undo,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Cash Flow'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: Icon(Icons.person_outline),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Snapshot (Cash on Hand)
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
                            '\$24,500',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.trending_up,
                            color: Colors.green.shade700,
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
          
          // Pipeline (Pending Funds)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildPipelineCard(
                    context,
                    label: 'Pending Receivables',
                    amount: '\$8,420',
                    amountColor: Colors.green.shade700,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPipelineCard(
                    context,
                    label: 'Pending Payables',
                    amount: '\$3,150',
                    amountColor: Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Ledger Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Recent Activity',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Ledger List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _recentActivity.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final tx = _recentActivity[index];
                final isPositive = tx.amount > 0;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    child: Icon(tx.icon, color: colorScheme.primary, size: 20),
                  ),
                  title: Text(
                    tx.name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(tx.date),
                  trailing: Text(
                    '${isPositive ? "+" : ""}\$${tx.amount.abs().toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isPositive ? Colors.green.shade700 : Colors.red.shade700,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Record'),
      ),
    );
  }

  Widget _buildPipelineCard(
    BuildContext context, {
    required String label,
    required String amount,
    required Color amountColor,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              amount,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: amountColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
