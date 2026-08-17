import 'package:flutter/material.dart';

class StreakBannerWidget extends StatefulWidget {
  const StreakBannerWidget({super.key});

  @override
  State<StreakBannerWidget> createState() => _StreakBannerWidgetState();
}

class _StreakBannerWidgetState extends State<StreakBannerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFC4622D).withAlpha(31),
            const Color(0xFFD4A017).withAlpha(26),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFC4622D).withAlpha(51)),
      ),
      child: Row(
        children: [
          ScaleTransition(
            scale: _scaleAnim,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFFADDD0),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('🔥', style: TextStyle(fontSize: 26)),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '38-Day Streak! 🎉',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: const Color(0xFFC4622D),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Keep it up! 12 more days to your 50-day milestone',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Milestone dots
          Column(
            children: [
              _MilestoneDot(label: '7', achieved: true),
              const SizedBox(height: 4),
              _MilestoneDot(label: '30', achieved: true),
              const SizedBox(height: 4),
              _MilestoneDot(label: '50', achieved: false),
            ],
          ),
        ],
      ),
    );
  }
}

class _MilestoneDot extends StatelessWidget {
  final String label;
  final bool achieved;
  const _MilestoneDot({required this.label, required this.achieved});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: achieved ? const Color(0xFFC4622D) : const Color(0xFFEEEEEE),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: achieved ? Colors.white : const Color(0xFFAAAAAA),
          ),
        ),
      ),
    );
  }
}
