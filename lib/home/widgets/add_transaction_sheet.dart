import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Ensure these point to your global widget locations
import '../../core/database/hive_service.dart';
import '../../ledger/models/transaction.dart';
import '../../shared/widgets/editorial_text_field.dart';
import '../../shared/widgets/primary_button.dart';

class AddTransactionSheet extends StatefulWidget {
  final bool initialIsMoneyIn; // Add this line

  const AddTransactionSheet({
    super.key,
    this.initialIsMoneyIn = false, // Default to Expense (Money Out)
  });

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  @override
  void initState() {
    super.initState();
    isMoneyIn = widget.initialIsMoneyIn; // Initialize from widget
  }

  // ... rest of your code remains the same ...
  // --- Form State ---
  late bool isMoneyIn = false; // Default to 'Money Out' as per hackathon tip
  bool isPaid = true;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _vendorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _vendorController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Formatting helper for premium editorial dates
  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  // Native Date Picker with Theme Overlay
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: Theme.of(context).colorScheme),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  // --- Submission Logic: The Magic Trick ---
  void _handleSave() async {
    final double amountValue = double.tryParse(_amountController.text) ?? 0.0;

    // Logic from your implementation plan
    String trackingCategory;
    if (!isPaid) {
      trackingCategory = isMoneyIn ? "Pending Receivable" : "Pending Payable";
    } else {
      trackingCategory = isMoneyIn ? "Income" : "Expense";
    }

    final newTransaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amountValue,
      isMoneyIn: isMoneyIn,
      isPaid: isPaid,
      vendorName: _vendorController.text,
      description: _descriptionController.text,
      date: selectedDate,
      category: trackingCategory,
    );

    // Save to Hive
    await HiveService.addTransaction(newTransaction);

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      // Dynamic padding to clear keyboard (Phase 1)
      padding: EdgeInsets.fromLTRB(
        24,
        12,
        24,
        bottomInset > 0 ? bottomInset + 24 : 40,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Drag Handle ---
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 32),

            // --- Phase 2: Type Toggle ---
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

            // --- Phase 2: Massive Amount Field ---
            TextField(
              controller: _amountController,
              autofocus: true,
              textAlign: TextAlign.center,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: GoogleFonts.manrope(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                letterSpacing: -2.0,
                color: isMoneyIn ? colorScheme.primary : colorScheme.onSurface,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
              decoration: InputDecoration(
                hintText: '\$0.00',
                hintStyle: GoogleFonts.manrope(
                  color: colorScheme.outlineVariant,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
            const SizedBox(height: 32),

            // --- Phase 3: Text Details ---
            EditorialTextField(
              label: 'Customer / Vendor Name',
              hintText: 'Who is this with?',
              // controller: _vendorController, // Connect these to your controllers
            ),
            const SizedBox(height: 16),

            EditorialTextField(
              label: 'Description',
              hintText: 'What is it for?',
              // controller: _descriptionController,
            ),
            const SizedBox(height: 24),

            // --- Phase 3 Updated: Inline Label & Input Layout ---

            // 1. Transaction Date Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isPaid ? 'Transaction Date' : 'Due Date',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: colorScheme.onSurface,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _pickDate,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _formatDate(selectedDate),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20), // Vertical spacing between the two rows
            // 2. Status Toggle Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: colorScheme.onSurface,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 4,
                    top: 2,
                    bottom: 2,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(
                      100,
                    ), // Rounded pill shape for status
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isPaid ? 'Paid' : 'Unpaid',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: isPaid
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Switch(
                        value: isPaid,
                        onChanged: (val) => setState(() => isPaid = val),
                        activeThumbColor: colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40), // Spacer before Save Button
            // --- Phase 4: Submission ---
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

  // --- Helper Builders ---

  Widget _buildInputLabel(String text, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildDateSelector(ColorScheme colorScheme) {
    return InkWell(
      onTap: _pickDate,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, size: 18, color: colorScheme.primary),
            const SizedBox(width: 12),
            Text(
              _formatDate(selectedDate),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusToggle(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isPaid ? 'Paid' : 'Unpaid',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: isPaid
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
          Switch(
            value: isPaid,
            onChanged: (val) => setState(() => isPaid = val),
            activeThumbColor: colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildTogglePill(
    String title,
    bool isActive,
    Color activeColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: activeColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: isActive
                ? Colors.white
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
