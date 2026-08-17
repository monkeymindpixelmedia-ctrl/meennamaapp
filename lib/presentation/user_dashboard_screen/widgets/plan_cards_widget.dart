import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PlanCardsWidget extends StatelessWidget {
  final String period;
  const PlanCardsWidget({super.key, required this.period});

  static const List<Map<String, dynamic>> _planCardsMaps = [
    {
      'label': 'FISH PLAN',
      'amount': '₹190',
      'change': '+38.0%',
      'positive': true,
      'icon': '🐠',
      'bars': [0.2, 0.35, 0.3, 0.5, 0.45, 0.6, 0.38],
    },
    {
      'label': 'GROCERY',
      'amount': '₹80',
      'change': '+16.0%',
      'positive': true,
      'icon': '🛒',
      'bars': [0.1, 0.2, 0.15, 0.25, 0.2, 0.3, 0.16],
    },
    {
      'label': 'OIL PLAN',
      'amount': '₹560',
      'change': '-4.2%',
      'positive': false,
      'icon': '🫙',
      'bars': [0.7, 0.65, 0.6, 0.55, 0.5, 0.48, 0.56],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _planCardsMaps.length,
        itemBuilder: (context, i) {
          final plan = _planCardsMaps[i];
          final bars = (plan['bars'] as List).cast<double>();
          final isPositive = plan['positive'] as bool;
          return _PlanCard(
            label: plan['label'] as String,
            amount: plan['amount'] as String,
            change: plan['change'] as String,
            icon: plan['icon'] as String,
            bars: bars,
            isPositive: isPositive,
          );
        },
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String label;
  final String amount;
  final String change;
  final String icon;
  final List<double> bars;
  final bool isPositive;

  const _PlanCard({
    required this.label,
    required this.amount,
    required this.change,
    required this.icon,
    required this.bars,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final changeColor = isPositive
        ? const Color(0xFF2D7A4F)
        : const Color(0xFFB91C1C);
    return Container(
      width: 148,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurfaceVariant,
                  letterSpacing: 0.8,
                ),
              ),
              Text(icon, style: const TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          // Mini bar chart
          SizedBox(
            height: 40,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                barTouchData: BarTouchData(enabled: false),
                titlesData: const FlTitlesData(show: false),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(bars.length, (i) {
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: bars[i] * 40,
                        color: theme.colorScheme.primary.withAlpha(153),
                        width: 8,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            change,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: changeColor,
            ),
          ),
        ],
      ),
    );
  }
}
