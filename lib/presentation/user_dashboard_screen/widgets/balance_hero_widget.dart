import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/status_badge_widget.dart';

class BalanceHeroWidget extends StatefulWidget {
  const BalanceHeroWidget({super.key});

  @override
  State<BalanceHeroWidget> createState() => _BalanceHeroWidgetState();
}

class _BalanceHeroWidgetState extends State<BalanceHeroWidget>
    with TickerProviderStateMixin {
  bool _todayPaid = false;
  bool _isPayingNow = false;
  late AnimationController _pulseController;
  late AnimationController _entryController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _entryFade;
  late Animation<Offset> _entrySlide;
  late Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _entryFade = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );
    _entrySlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entryController,
            curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
          ),
        );
    _progressAnim = Tween<double>(begin: 0.0, end: 0.38).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    Future.delayed(const Duration(milliseconds: 80), () {
      if (mounted) _entryController.forward();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  Future<void> _payNow() async {
    setState(() => _isPayingNow = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() {
      _isPayingNow = false;
      _todayPaid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _entryFade,
      child: SlideTransition(
        position: _entrySlide,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0D2E47), Color(0xFF1B4A6B), Color(0xFF2E6B9E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.5, 1.0],
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1B4A6B).withAlpha(90),
                blurRadius: 28,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TODAY\'S PAYMENT',
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withAlpha(160),
                      letterSpacing: 1.4,
                    ),
                  ),
                  StatusBadgeWidget(
                    status: _todayPaid ? BadgeStatus.paid : BadgeStatus.pending,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Amount display
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹5',
                    style: GoogleFonts.fraunces(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.0,
                      letterSpacing: -1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Text(
                      '.00',
                      style: GoogleFonts.fraunces(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withAlpha(160),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Day 38 of 100',
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: Colors.white.withAlpha(220),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '₹190 of ₹500',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          color: Colors.white.withAlpha(150),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // Animated progress bar
              AnimatedBuilder(
                animation: _progressAnim,
                builder: (context, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: LinearProgressIndicator(
                          value: _progressAnim.value,
                          backgroundColor: Colors.white.withAlpha(40),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFD4A017),
                          ),
                          minHeight: 7,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${(_progressAnim.value * 100).toInt()}% complete',
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          color: Colors.white.withAlpha(130),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (_, child) => Transform.scale(
                        scale: !_todayPaid ? _pulseAnimation.value : 1.0,
                        child: child,
                      ),
                      child: _PayButton(
                        isPaid: _todayPaid,
                        isLoading: _isPayingNow,
                        onTap: _todayPaid || _isPayingNow ? null : _payNow,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: CustomIconWidget(
                        iconName: 'south_west',
                        color: Colors.white,
                        size: 16,
                      ),
                      label: Text(
                        'HISTORY',
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.white.withAlpha(100),
                          width: 1.5,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PayButton extends StatefulWidget {
  final bool isPaid;
  final bool isLoading;
  final VoidCallback? onTap;
  const _PayButton({
    required this.isPaid,
    required this.isLoading,
    required this.onTap,
  });

  @override
  State<_PayButton> createState() => _PayButtonState();
}

class _PayButtonState extends State<_PayButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap != null ? (_) => _ctrl.forward() : null,
      onTapUp: widget.onTap != null
          ? (_) {
              _ctrl.reverse();
              widget.onTap!();
            }
          : null,
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: widget.isPaid ? const Color(0xFF2D7A4F) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: widget.isPaid
                ? []
                : [
                    BoxShadow(
                      color: Colors.white.withAlpha(60),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Color(0xFF1B4A6B),
                    strokeWidth: 2,
                  ),
                )
              else
                Icon(
                  widget.isPaid
                      ? Icons.check_rounded
                      : Icons.north_east_rounded,
                  size: 16,
                  color: widget.isPaid ? Colors.white : const Color(0xFF1B4A6B),
                ),
              const SizedBox(width: 6),
              Text(
                widget.isPaid ? 'Paid Today ✓' : 'PAY NOW',
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: widget.isPaid ? Colors.white : const Color(0xFF1B4A6B),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
