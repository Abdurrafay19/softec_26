import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterChipRow extends StatelessWidget {
  const FilterChipRow({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const List<String> _filters = ['All', 'Income', 'Expenses'];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        // 1.2 The Scrolling Chips
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // Hides the scrollbar for a cleaner UI
            clipBehavior: Clip.none,
            child: Row(
              children: List.generate(_filters.length, (index) {
                final isSelected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () => onSelected(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        // Active: Primary | Inactive: SurfaceContainerHighest
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        _filters[index],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          // Active: onPrimary | Inactive: onSurfaceVariant
                          color: isSelected
                              ? colorScheme.onPrimary
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),

        const SizedBox(width: 12),

      ],
    );
  }
}