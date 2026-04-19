import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ledger/models/transaction.dart';
import '../../ledger/transaction_provider.dart';
import '../../shared/widgets/editorial_text_field.dart';
import '../../shared/widgets/primary_button.dart';

class AddTransactionSheet extends ConsumerStatefulWidget {
  final bool initialIsMoneyIn;

  const AddTransactionSheet({
    super.key,
    this.initialIsMoneyIn = false,
  });

  @override
  ConsumerState<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends ConsumerState<AddTransactionSheet> {
  late bool isMoneyIn;
  DateTime selectedDate = DateTime.now();
  String selectedCategory = 'General';

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> categories = [
    'General',
    'Food',
    'Bills',
    'Shopping',
    'Transport',
    'Entertainment',
    'Health',
    'Business',
    'Income',
  ];

  @override
  void initState() {
    super.initState();
    isMoneyIn = widget.initialIsMoneyIn;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(), // Restrict to past or today
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  void _handleSave() async {
    // 1. Check if Amount is empty or zero
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      _showError('Please enter an amount');
      return;
    }

    final double? amountValue = double.tryParse(amountText);
    if (amountValue == null || amountValue <= 0) {
      _showError('Please enter a valid amount greater than 0');
      return;
    }

    // 2. Check if Name is empty
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      _showError('Please enter a transaction name');
      return;
    }

    // 3. Confirm Category
    if (selectedCategory.isEmpty) {
      _showError('Please select a category');
      return;
    }

    final newTransaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amountValue,
      isMoneyIn: isMoneyIn,
      name: name,
      description: _descriptionController.text.trim(),
      date: selectedDate,
      category: selectedCategory,
    );

    // Use Riverpod to save and notify listeners
    await ref.read(transactionsProvider.notifier).addTransaction(newTransaction);
    
    if (mounted) Navigator.pop(context);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(
        24, 12, 24, bottomInset > 0 ? bottomInset + 24 : 40,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTogglePill(
                      'Money Out',
                      !isMoneyIn,
                      colorScheme.error,
                      () => setState(() => isMoneyIn = false),
                    ),
                  ),
                  Expanded(
                    child: _buildTogglePill(
                      'Money In',
                      isMoneyIn,
                      colorScheme.primary,
                      () => setState(() => isMoneyIn = true),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            TextField(
              controller: _amountController,
              autofocus: true,
              textAlign: TextAlign.center,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: GoogleFonts.manrope(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                letterSpacing: -2.0,
                color: isMoneyIn ? colorScheme.primary : colorScheme.onSurface,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
              decoration: InputDecoration(
                hintText: '\$0.00',
                hintStyle: GoogleFonts.manrope(color: colorScheme.outlineVariant),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
            const SizedBox(height: 32),

            EditorialTextField(
              label: 'Name',
              hintText: 'e.g. Weekly Groceries',
              controller: _nameController,
            ),
            const SizedBox(height: 16),

            EditorialTextField(
              label: 'Description',
              hintText: 'Add a note...',
              controller: _descriptionController,
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: _pickDate,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16, color: colorScheme.primary),
                              const SizedBox(width: 8),
                              Text(
                                _formatDate(selectedDate),
                                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCategory,
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down, color: colorScheme.primary),
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface,
                            ),
                            items: categories.map((String category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() => selectedCategory = newValue);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            PrimaryButton(
              text: 'Save Transaction',
              icon: Icons.check_circle_outline,
              onPressed: _handleSave,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTogglePill(String title, bool isActive, Color activeColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
