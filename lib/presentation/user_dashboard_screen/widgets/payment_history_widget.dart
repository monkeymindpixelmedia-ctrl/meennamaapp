import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/status_badge_widget.dart';

class PaymentHistoryWidget extends StatelessWidget {
  final String period;
  const PaymentHistoryWidget({super.key, required this.period});

  static const List<Map<String, dynamic>> _paymentMaps = [
    {
      'date': 'TODAY, AUG 13',
      'items': [
        {
          'icon': 'local_fire_department',
          'iconBg': 0xFFFADDD0,
          'iconColor': 0xFFC4622D,
          'name': 'Fish Plan',
          'category': 'Daily Subscription',
          'amount': '₹5.00',
          'time': '08:32 AM',
          'status': 'pending',
        },
      ],
    },
    {
      'date': 'YESTERDAY, AUG 12',
      'items': [
        {
          'icon': 'local_fire_department',
          'iconBg': 0xFFD4EDDE,
          'iconColor': 0xFF2D7A4F,
          'name': 'Fish Plan',
          'category': 'Daily Subscription',
          'amount': '₹5.00',
          'time': '09:14 AM',
          'status': 'paid',
        },
        {
          'icon': 'savings',
          'iconBg': 0xFFD0E8F5,
          'iconColor': 0xFF1B4A6B,
          'name': 'Grocery Plan',
          'category': 'Daily Subscription',
          'amount': '₹2.00',
          'time': '09:14 AM',
          'status': 'paid',
        },
      ],
    },
    {
      'date': 'AUG 11',
      'items': [
        {
          'icon': 'local_fire_department',
          'iconBg': 0xFFD4EDDE,
          'iconColor': 0xFF2D7A4F,
          'name': 'Fish Plan',
          'category': 'Daily Subscription',
          'amount': '₹5.00',
          'time': '07:58 AM',
          'status': 'paid',
        },
      ],
    },
    {
      'date': 'AUG 10',
      'items': [
        {
          'icon': 'local_fire_department',
          'iconBg': 0xFFFEE2E2,
          'iconColor': 0xFFB91C1C,
          'name': 'Fish Plan',
          'category': 'Daily Subscription',
          'amount': '₹5.00',
          'time': '—',
          'status': 'missed',
        },
      ],
    },
    {
      'date': 'AUG 9',
      'items': [
        {
          'icon': 'local_fire_department',
          'iconBg': 0xFFD4EDDE,
          'iconColor': 0xFF2D7A4F,
          'name': 'Fish Plan',
          'category': 'Daily Subscription',
          'amount': '₹5.00',
          'time': '10:22 AM',
          'status': 'paid',
        },
      ],
    },
  ];

  BadgeStatus _statusFromString(String s) {
    switch (s) {
      case 'paid':
        return BadgeStatus.paid;
      case 'pending':
        return BadgeStatus.pending;
      case 'failed':
        return BadgeStatus.failed;
      case 'missed':
        return BadgeStatus.missed;
      default:
        return BadgeStatus.pending;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: _paymentMaps.map((group) {
          final items = (group['items'] as List).cast<Map<String, dynamic>>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      group['date'] as String,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ),
              ...items.map(
                (item) => _PaymentItemRow(
                  item: item,
                  status: _statusFromString(item['status'] as String),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _PaymentItemRow extends StatelessWidget {
  final Map<String, dynamic> item;
  final BadgeStatus status;
  const _PaymentItemRow({required this.item, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMuted = status == BadgeStatus.missed;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Circular icon — extracted anatomy: circular avatar 40px
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
                    color: isMuted
                        ? theme.colorScheme.onSurfaceVariant
                        : theme.colorScheme.onSurface,
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
          // Amount + time column
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item['amount'] as String,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isMuted
                      ? theme.colorScheme.onSurfaceVariant
                      : theme.colorScheme.onSurface,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(height: 3),
              StatusBadgeWidget(status: status, fontSize: 10),
            ],
          ),
        ],
      ),
    );
  }
}
