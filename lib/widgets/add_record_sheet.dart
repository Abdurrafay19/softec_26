import 'package:flutter/material.dart';
import '../models/transaction.dart';

class AddRecordSheet extends StatefulWidget {
  final Function(Transaction) onSave;

  const AddRecordSheet({super.key, required this.onSave});

  @override
  State<AddRecordSheet> createState() => _AddRecordSheetState();
}

class _AddRecordSheetState extends State<AddRecordSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  bool _isIncome = true;
  bool _isPending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final amountValue = double.parse(_amountController.text);
      final finalAmount = _isIncome ? amountValue : -amountValue;

      final newTransaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        date: DateTime.now(),
        amount: finalAmount,
        icon: _isIncome ? Icons.account_balance_wallet : Icons.shopping_cart,
        isPending: _isPending,
      );

      widget.onSave(newTransaction);
      Navigator.pop(context); // Close the sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    // Padding handles the keyboard pushing the sheet up
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add New Record', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),

            // Income vs Expense Toggle
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text('Income')),
                ButtonSegment(value: false, label: Text('Expense')),
              ],
              selected: {_isIncome},
              onSelectionChanged: (Set<bool> newSelection) {
                setState(() => _isIncome = newSelection.first);
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Transaction Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Enter a name' : null,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '\$ ',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Enter an amount';
                if (double.tryParse(value) == null) return 'Enter a valid number';
                return null;
              },
            ),
            const SizedBox(height: 16),

            CheckboxListTile(
              title: const Text('Mark as Pending'),
              subtitle: const Text('This will track in your pipeline cards'),
              value: _isPending,
              onChanged: (bool? value) {
                setState(() => _isPending = value ?? false);
              },
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _submitForm,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Save Record'),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}