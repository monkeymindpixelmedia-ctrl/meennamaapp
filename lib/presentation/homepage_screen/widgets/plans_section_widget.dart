import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_theme.dart';

class PlansSectionWidget extends StatefulWidget {
  const PlansSectionWidget({super.key});

  @override
  State<PlansSectionWidget> createState() => _PlansSectionWidgetState();
}

class _PlansSectionWidgetState extends State<PlansSectionWidget>
    with TickerProviderStateMixin {
  late AnimationController _staggerController;
  late List<Animation<double>> _cardScales;
  late List<Animation<double>> _cardOpacities;
  int _selectedPlan = 2;

  final List<_PlanData> _plans = [
    _PlanData(
      amount: '₹1',
      perDay: '1',
      label: 'Starter',
      days: 60,
      total: '₹60',
      reward: 'Spice Bundle',
      rewardDetail: 'Turmeric, chilli & coriander',
      icon: '🌶️',
      color: const Color(0xFF2D7A4F),
      lightColor: const Color(0xFFD4EDDE),
    ),
    _PlanData(
      amount: '₹2',
      perDay: '2',
      label: 'Daily',
      days: 90,
      total: '₹180',
      reward: 'Dry Fish Pack',
      rewardDetail: 'Nethili & Karuvaadu mix',
      icon: '🐠',
      color: const Color(0xFF1B4A6B),
      lightColor: const Color(0xFFD0E8F5),
    ),
    _PlanData(
      amount: '₹5',
      perDay: '5',
      label: 'Family',
      days: 100,
      total: '₹500',
      reward: 'Fish Hamper',
      rewardDetail: '2kg seasonal catch, cleaned',
      icon: '🐟',
      color: AppTheme.secondary,
      lightColor: AppTheme.secondaryContainer,
      isPopular: true,
    ),
    _PlanData(
      amount: '₹10',
      perDay: '10',
      label: 'Premium',
      days: 100,
      total: '₹1,000',
      reward: 'Grocery + Oil Bundle',
      rewardDetail: 'Rice, dal, sesame & coconut oil',
      icon: '🛒',
      color: const Color(0xFFB45309),
      lightColor: const Color(0xFFFEF3C7),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _cardScales = List.generate(_plans.length, (i) {
      return Tween<double>(begin: 0.88, end: 1.0).animate(
        CurvedAnimation(
          parent: _staggerController,
          curve: Interval(i * 0.15, 0.55 + i * 0.12, curve: Curves.elasticOut),
        ),
      );
    });

    _cardOpacities = List.generate(_plans.length, (i) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _staggerController,
          curve: Interval(i * 0.15, 0.45 + i * 0.12, curve: Curves.easeOut),
        ),
      );
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) _staggerController.forward();
    });
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundLight,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(),
          const SizedBox(height: 36),
          _buildBentoGrid(),
          const SizedBox(height: 24),
          _buildStartCta(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppTheme.primaryContainer,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            'SUBSCRIPTION PLANS',
            style: GoogleFonts.dmSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.primary,
              letterSpacing: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Choose your\ndaily amount.',
          style: GoogleFonts.fraunces(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A1A),
            height: 1.15,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Small daily payments. Real household rewards at the end of your cycle.',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: const Color(0xFF6A6A6A),
            height: 1.6,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }

  Widget _buildBentoGrid() {
    // Asymmetric bento: top row has featured (₹5) large + ₹1 small
    // Bottom row has ₹2 medium + ₹10 medium
    return Column(
      children: [
        // Row 1: Popular plan large + starter small
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 5, child: _buildAnimatedCard(2, isHero: true)),
            const SizedBox(width: 10),
            Expanded(flex: 3, child: _buildAnimatedCard(0, isHero: false)),
          ],
        ),
        const SizedBox(height: 10),
        // Row 2: two equal cards
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildAnimatedCard(1, isHero: false)),
            const SizedBox(width: 10),
            Expanded(child: _buildAnimatedCard(3, isHero: false)),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimatedCard(int index, {required bool isHero}) {
    return AnimatedBuilder(
      animation: _staggerController,
      builder: (context, child) {
        return Transform.scale(
          scale: _cardScales[index].value,
          child: Opacity(
            opacity: _cardOpacities[index].value.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: _PlanBentoCard(
        plan: _plans[index],
        isSelected: _selectedPlan == index,
        isHero: isHero,
        onTap: () => setState(() => _selectedPlan = index),
      ),
    );
  }

  Widget _buildStartCta(BuildContext context) {
    final selected = _plans[_selectedPlan];
    return GestureDetector(
      onTap: () => context.go(AppRoutes.signUpLogin),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        decoration: BoxDecoration(
          color: selected.color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: selected.color.withAlpha(80),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(selected.icon, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Text(
              'Start ${selected.label} Plan — ${selected.amount}/day',
              style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanBentoCard extends StatefulWidget {
  final _PlanData plan;
  final bool isSelected;
  final bool isHero;
  final VoidCallback onTap;

  const _PlanBentoCard({
    required this.plan,
    required this.isSelected,
    required this.isHero,
    required this.onTap,
  });

  @override
  State<_PlanBentoCard> createState() => _PlanBentoCardState();
}

class _PlanBentoCardState extends State<_PlanBentoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _pressScale;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _pressScale = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _pressController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plan = widget.plan;
    final selected = widget.isSelected;
    final isHero = widget.isHero;

    return GestureDetector(
      onTapDown: (_) => _pressController.forward(),
      onTapUp: (_) {
        _pressController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _pressController.reverse(),
      child: AnimatedBuilder(
        animation: _pressController,
        builder: (context, child) =>
            Transform.scale(scale: _pressScale.value, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.all(isHero ? 20.0 : 16.0),
          decoration: BoxDecoration(
            color: selected ? plan.color : AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: selected ? plan.color : const Color(0xFFE8E4DF),
              width: selected ? 0 : 1.5,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: plan.color.withAlpha(70),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withAlpha(8),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: isHero
              ? _buildHeroContent(plan, selected)
              : _buildCompactContent(plan, selected),
        ),
      ),
    );
  }

  Widget _buildHeroContent(_PlanData plan, bool selected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selected ? Colors.white.withAlpha(40) : plan.lightColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(plan.icon, style: const TextStyle(fontSize: 24)),
            ),
            const Spacer(),
            if (plan.isPopular)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? Colors.white.withAlpha(40)
                      : AppTheme.accent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  '✦ Popular',
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: selected ? Colors.white : Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          plan.amount,
          style: GoogleFonts.fraunces(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : plan.color,
            letterSpacing: -1.0,
            height: 1.0,
          ),
        ),
        Text(
          'per day',
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: selected
                ? Colors.white.withAlpha(180)
                : const Color(0xFF8A8A8A),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          plan.label,
          style: GoogleFonts.dmSans(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${plan.days} days · ${plan.total} total',
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: selected
                ? Colors.white.withAlpha(180)
                : const Color(0xFF8A8A8A),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? Colors.white.withAlpha(30) : plan.lightColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Text('🎁', style: const TextStyle(fontSize: 13)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  plan.reward,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : plan.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactContent(_PlanData plan, bool selected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(plan.icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        Text(
          plan.amount,
          style: GoogleFonts.fraunces(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : plan.color,
            letterSpacing: -0.8,
            height: 1.0,
          ),
        ),
        Text(
          '/day',
          style: GoogleFonts.dmSans(
            fontSize: 11,
            color: selected
                ? Colors.white.withAlpha(170)
                : const Color(0xFF8A8A8A),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          plan.label,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          plan.reward,
          style: GoogleFonts.dmSans(
            fontSize: 11,
            color: selected
                ? Colors.white.withAlpha(170)
                : const Color(0xFF8A8A8A),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _PlanData {
  final String amount;
  final String perDay;
  final String label;
  final int days;
  final String total;
  final String reward;
  final String rewardDetail;
  final String icon;
  final Color color;
  final Color lightColor;
  final bool isPopular;

  const _PlanData({
    required this.amount,
    required this.perDay,
    required this.label,
    required this.days,
    required this.total,
    required this.reward,
    required this.rewardDetail,
    required this.icon,
    required this.color,
    required this.lightColor,
    this.isPopular = false,
  });
}
