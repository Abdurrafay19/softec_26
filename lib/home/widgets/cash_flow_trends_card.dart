import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../ledger/transaction_provider.dart';

class CashFlowTrendsCard extends ConsumerWidget {
  const CashFlowTrendsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final transactions = ref.watch(transactionsProvider).transactions;

    // 1. Logic to get the last 8 days including today
    final now = DateTime.now();
    final List<DateTime> last8Days = List.generate(8, (index) {
      return DateTime(now.year, now.month, now.day).subtract(Duration(days: 7 - index));
    });

    // 2. Aggregate net values for each day
    final Map<String, double> dailyNet = {};
    for (var date in last8Days) {
      final dateKey = DateFormat('yyyy-MM-dd').format(date);
      dailyNet[dateKey] = 0.0;
    }

    for (var tx in transactions) {
      final txDateKey = DateFormat('yyyy-MM-dd').format(tx.date);
      if (dailyNet.containsKey(txDateKey)) {
        if (tx.isMoneyIn) {
          dailyNet[txDateKey] = (dailyNet[txDateKey] ?? 0.0) + tx.amount;
        } else {
          dailyNet[txDateKey] = (dailyNet[txDateKey] ?? 0.0) - tx.amount;
        }
      }
    }

    // 3. Convert to BarChartGroups
    final List<BarChartGroupData> barGroups = [];
    double maxAbsValue = 100.0; // Minimum scale height

    for (int i = 0; i < 8; i++) {
      final dateKey = DateFormat('yyyy-MM-dd').format(last8Days[i]);
      final netValue = dailyNet[dateKey] ?? 0.0;
      
      if (netValue.abs() > maxAbsValue) maxAbsValue = netValue.abs();

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: netValue.abs() == 0 ? 2.0 : netValue.abs(), 
              // Using theme colors instead of hardcoded saturated greens
              color: netValue >= 0 ? colorScheme.primary : colorScheme.error,
              width: 22, // Increased thickness
              borderRadius: BorderRadius.circular(6), // Premium rounded corners
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: maxAbsValue,
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.04),
            blurRadius: 40,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Budget Trend',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Net expenditures (Last 8 days)',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          
          AspectRatio(
            aspectRatio: 1.7,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxAbsValue * 1.2,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => colorScheme.surfaceContainerHigh,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final net = dailyNet[DateFormat('yyyy-MM-dd').format(last8Days[group.x.toInt()])]!;
                      return BarTooltipItem(
                        '${net >= 0 ? '+' : '-'}\$${net.abs().toStringAsFixed(0)}',
                        GoogleFonts.inter(
                          color: net >= 0 ? colorScheme.primary : colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= 8) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            DateFormat('dd/MM').format(last8Days[index]),
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: barGroups,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
