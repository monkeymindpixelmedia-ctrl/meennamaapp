import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class MetricGridWidget extends StatelessWidget {
  const MetricGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metrics = [
      _MetricData(
        label: 'STREAK',
        icon: 'local_fire_department',
        value: '38',
        subtext: 'days in a row',
        iconColor: const Color(0xFFC4622D),
        bgColor: const Color(0xFFFADDD0),
      ),
      _MetricData(
        label: 'SAVE',
        icon: 'savings',
        value: '₹125,181',
        subtext: '23.8%',
        iconColor: const Color(0xFF2D7A4F),
        bgColor: const Color(0xFFD4EDDE),
      ),
      _MetricData(
        label: 'CYCLE',
        icon: 'rotate_right',
        value: '38%',
        subtext: '62 days left',
        iconColor: const Color(0xFF1B4A6B),
        bgColor: const Color(0xFFD0E8F5),
      ),
      _MetricData(
        label: 'REWARD',
        icon: 'redeem',
        value: '62',
        subtext: 'days to go',
        iconColor: const Color(0xFFD4A017),
        bgColor: const Color(0xFFF9ECC8),
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: 1.55,
      children: metrics.map((m) => _MetricCard(data: m)).toList(),
    );
  }
}

class _MetricData {
  final String label;
  final String icon;
  final String value;
  final String subtext;
  final Color iconColor;
  final Color bgColor;

  const _MetricData({
    required this.label,
    required this.icon,
    required this.value,
    required this.subtext,
    required this.iconColor,
    required this.bgColor,
  });
}

class _MetricCard extends StatelessWidget {
  final _MetricData data;
  const _MetricCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 12,
            offset: const Offset(0, 3),
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
                data.label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurfaceVariant,
                  letterSpacing: 0.8,
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: data.bgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: data.icon,
                    color: data.iconColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            data.value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            data.subtext,
            style: TextStyle(
              fontSize: 11,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
