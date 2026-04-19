import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../core/database/hive_service.dart';
import '../../shared/widgets/editorial_text_field.dart';
import '../../shared/widgets/primary_button.dart';
import '../models/goal.dart';

class AddEditGoalScreen extends StatefulWidget {
  final Goal? goal;

  const AddEditGoalScreen({super.key, this.goal});

  @override
  State<AddEditGoalScreen> createState() => _AddEditGoalScreenState();
}

class _AddEditGoalScreenState extends State<AddEditGoalScreen> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.goal?.name ?? '');
    _amountController = TextEditingController(
      text: widget.goal?.targetAmount.toString() ?? '',
    );
    _selectedDate = widget.goal?.dueDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveGoal() {
    final name = _nameController.text.trim();
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (name.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid name and amount')),
      );
      return;
    }

    final goal = Goal(
      id: widget.goal?.id ?? const Uuid().v4(),
      name: name,
      targetAmount: amount,
      dueDate: _selectedDate,
      currentAmount: widget.goal?.currentAmount ?? 0.0,
    );

    HiveService.addGoal(goal);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          widget.goal == null ? 'Add Goal' : 'Edit Goal',
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EditorialTextField(
              label: 'Goal Name',
              hintText: 'e.g., Office Expansion',
              controller: _nameController,
            ),
            const SizedBox(height: 24),
            EditorialTextField(
              label: 'Target Amount',
              hintText: '0.00',
              controller: _amountController,
            ),
            const SizedBox(height: 24),
            Text(
              'Target Date',
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _selectDate(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 20, color: colorScheme.primary),
                    const SizedBox(width: 12),
                    Text(
                      _selectedDate == null
                          ? 'No due date'
                          : DateFormat.yMMMd().format(_selectedDate!),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    if (_selectedDate != null)
                      IconButton(
                        icon: Icon(Icons.close, size: 20, color: colorScheme.onSurfaceVariant),
                        onPressed: () => setState(() => _selectedDate = null),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
            PrimaryButton(
              text: widget.goal == null ? 'Create Goal' : 'Save Changes',
              icon: Icons.save,
              onPressed: _saveGoal,
            ),
          ],
        ),
      ),
    );
  }
}
