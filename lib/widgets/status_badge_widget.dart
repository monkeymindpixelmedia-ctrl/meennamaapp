import 'package:flutter/material.dart';

enum BadgeStatus { paid, pending, failed, missed, active, completed, available }

class StatusBadgeWidget extends StatelessWidget {
  final BadgeStatus status;
  final String? customLabel;
  final double fontSize;

  const StatusBadgeWidget({
    super.key,
    required this.status,
    this.customLabel,
    this.fontSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = _resolve(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        customLabel ?? label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: fg,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  (String, Color, Color) _resolve(BadgeStatus s) {
    switch (s) {
      case BadgeStatus.paid:
        return ('Paid', const Color(0xFFD4EDDE), const Color(0xFF2D7A4F));
      case BadgeStatus.pending:
        return ('Pending', const Color(0xFFFEF3C7), const Color(0xFFB45309));
      case BadgeStatus.failed:
        return ('Failed', const Color(0xFFFEE2E2), const Color(0xFFB91C1C));
      case BadgeStatus.missed:
        return ('Missed', const Color(0xFFF5E6E6), const Color(0xFF9B2C2C));
      case BadgeStatus.active:
        return ('Active', const Color(0xFFD0E8F5), const Color(0xFF1B4A6B));
      case BadgeStatus.completed:
        return ('Completed', const Color(0xFFD4EDDE), const Color(0xFF2D7A4F));
      case BadgeStatus.available:
        return ('Available', const Color(0xFFFADDD0), const Color(0xFFC4622D));
    }
  }
}
