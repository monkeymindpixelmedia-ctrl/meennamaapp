import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class CompletedRewardsWidget extends StatelessWidget {
  const CompletedRewardsWidget({super.key});

  static const List<Map<String, dynamic>> _completedMaps = [
    {
      'icon': 'local_fire_department',
      'iconBg': 0xFFD4EDDE,
      'iconColor': 0xFF2D7A4F,
      'name': 'Dry Fish Bundle',
      'category': 'Fish · 100-day cycle',
      'value': '₹200',
      'date': 'JUL 15, 2026',
      'status': 'completed',
    },
    {
      'icon': 'water_drop',
      'iconBg': 0xFFF9ECC8,
      'iconColor': 0xFFD4A017,
      'name': 'Cooking Oil Pack',
      'category': 'Oil & Spice · 100-day cycle',
      'value': '₹300',
      'date': 'APR 2, 2026',
      'status': 'completed',
    },
    {
      'icon': 'redeem',
      'iconBg': 0xFFD0E8F5,
      'iconColor': 0xFF1B4A6B,
      'name': 'Spice Bundle',
      'category': 'Oil & Spice · 100-day cycle',
      'value': '₹100',
      'date': 'JAN 10, 2026',
      'status': 'completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: _completedMaps.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              // Circular icon — extracted PaymentItem anatomy
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Color(item['iconBg'] as int),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: item['icon'] as String,
                    color: Color(item['iconColor'] as int),
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Name + category column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] as String,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item['category'] as String,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              // Value + date column
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item['value'] as String,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item['date'] as String,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
