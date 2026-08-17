import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_theme.dart';

class HeroSectionWidget extends StatefulWidget {
  const HeroSectionWidget({super.key});

  @override
  State<HeroSectionWidget> createState() => _HeroSectionWidgetState();
}

class _HeroSectionWidgetState extends State<HeroSectionWidget>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _entryController;
  late AnimationController _kudamController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;
  late Animation<double> _kudamFill;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _kudamController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fadeIn = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );

    _slideUp = Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entryController,
            curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
          ),
        );

    _kudamFill = Tween<double>(begin: 0.0, end: 0.62).animate(
      CurvedAnimation(parent: _kudamController, curve: Curves.easeOutCubic),
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _entryController.forward();
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) _kudamController.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    _entryController.dispose();
    _kudamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height * 0.88),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0D2E47),
            Color(0xFF1B4A6B),
            Color(0xFF1E5578),
            Color(0xFF2A6B8A),
          ],
          stops: [0.0, 0.35, 0.65, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Animated wave background
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _waveController,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(size.width, 180),
                  painter: _WavePainter(
                    animValue: _waveController.value,
                    color: AppTheme.backgroundLight,
                  ),
                );
              },
            ),
          ),
          // Subtle fish-scale pattern overlay
          Positioned.fill(child: CustomPaint(painter: _FishScalePainter())),
          // Main content
          Padding(
            padding: EdgeInsets.fromLTRB(24, size.height * 0.13, 24, 100),
            child: FadeTransition(
              opacity: _fadeIn,
              child: SlideTransition(
                position: _slideUp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.accent.withAlpha(51),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: AppTheme.accent.withAlpha(102),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('🪔', style: TextStyle(fontSize: 13)),
                          const SizedBox(width: 6),
                          Text(
                            'Tamil குடும் Savings',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.accent,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    // Headline
                    Text(
                      'ஒவ்வொரு நாளும்\nஒரு சிறு தொகை.',
                      style: GoogleFonts.fraunces(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.18,
                        letterSpacing: -0.8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Every day, a little.\nAt the end, something real.',
                      style: GoogleFonts.fraunces(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withAlpha(199),
                        height: 1.35,
                        fontStyle: FontStyle.italic,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Pay ₹1 to ₹10 a day. Complete your cycle.\nReceive fish, oil, spices — real household goods.',
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withAlpha(173),
                        height: 1.6,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // CTA buttons
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => context.go(AppRoutes.signUpLogin),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: AppTheme.secondary,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.secondary.withAlpha(102),
                                    blurRadius: 20,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Start Saving Today',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => context.go(AppRoutes.signUpLogin),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(26),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.white.withAlpha(64),
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: GoogleFonts.dmSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Kudam visual
                    Center(
                      child: AnimatedBuilder(
                        animation: _kudamFill,
                        builder: (context, child) {
                          return _KudamWidget(fillLevel: _kudamFill.value);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Stats row
                    _buildStatsRow(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _StatChip(icon: '👨‍👩‍👧', label: '2,400+', sub: 'Families'),
        const SizedBox(width: 10),
        _StatChip(icon: '🐟', label: '₹18L+', sub: 'Rewards Given'),
        const SizedBox(width: 10),
        _StatChip(icon: '📅', label: '4 Plans', sub: 'Starting ₹1/day'),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String icon;
  final String label;
  final String sub;
  const _StatChip({required this.icon, required this.label, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(20),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withAlpha(31)),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.fraunces(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              sub,
              style: GoogleFonts.dmSans(
                fontSize: 10,
                color: Colors.white.withAlpha(153),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KudamWidget extends StatelessWidget {
  final double fillLevel;
  const _KudamWidget({required this.fillLevel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 120,
          height: 140,
          child: CustomPaint(painter: _KudamPainter(fillLevel: fillLevel)),
        ),
        const SizedBox(height: 8),
        Text(
          '${(fillLevel * 100).toInt()}% filled',
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: Colors.white.withAlpha(153),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _KudamPainter extends CustomPainter {
  final double fillLevel;
  _KudamPainter({required this.fillLevel});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Kudam body path
    final bodyPath = Path();
    bodyPath.moveTo(w * 0.25, h * 0.15);
    bodyPath.quadraticBezierTo(w * 0.1, h * 0.3, w * 0.08, h * 0.55);
    bodyPath.quadraticBezierTo(w * 0.06, h * 0.85, w * 0.3, h * 0.95);
    bodyPath.lineTo(w * 0.7, h * 0.95);
    bodyPath.quadraticBezierTo(w * 0.94, h * 0.85, w * 0.92, h * 0.55);
    bodyPath.quadraticBezierTo(w * 0.9, h * 0.3, w * 0.75, h * 0.15);
    bodyPath.close();

    // Fill water
    if (fillLevel > 0) {
      final fillY = h * 0.95 - (h * 0.75 * fillLevel);
      final fillPath = Path();
      fillPath.moveTo(w * 0.08, fillY + 5);
      fillPath.quadraticBezierTo(w * 0.5, fillY - 8, w * 0.92, fillY + 5);
      fillPath.lineTo(w * 0.92, h * 0.95);
      fillPath.quadraticBezierTo(w * 0.94, h * 0.85, w * 0.92, h * 0.55);
      fillPath.quadraticBezierTo(w * 0.9, h * 0.3, w * 0.75, h * 0.15);
      fillPath.lineTo(w * 0.25, h * 0.15);
      fillPath.quadraticBezierTo(w * 0.1, h * 0.3, w * 0.08, h * 0.55);
      fillPath.close();

      canvas.save();
      canvas.clipPath(bodyPath);
      final fillPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF2A8FBF).withAlpha(217),
            const Color(0xFF1B5E8A),
          ],
        ).createShader(Rect.fromLTWH(0, 0, w, h));
      canvas.drawPath(fillPath, fillPaint);
      canvas.restore();
    }

    // Kudam outline
    final outlinePaint = Paint()
      ..color = Colors.white.withAlpha(179)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawPath(bodyPath, outlinePaint);

    // Neck
    final neckPaint = Paint()
      ..color = Colors.white.withAlpha(179)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawLine(
      Offset(w * 0.3, h * 0.15),
      Offset(w * 0.3, h * 0.06),
      neckPaint,
    );
    canvas.drawLine(
      Offset(w * 0.7, h * 0.15),
      Offset(w * 0.7, h * 0.06),
      neckPaint,
    );
    canvas.drawLine(
      Offset(w * 0.25, h * 0.06),
      Offset(w * 0.75, h * 0.06),
      neckPaint,
    );

    // Coin drop dots
    if (fillLevel > 0.1) {
      final coinPaint = Paint()
        ..color = AppTheme.accent.withAlpha(230)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(w * 0.5, h * 0.06), 5, coinPaint);
    }
  }

  @override
  bool shouldRepaint(_KudamPainter old) => old.fillLevel != fillLevel;
}

class _WavePainter extends CustomPainter {
  final double animValue;
  final Color color;
  _WavePainter({required this.animValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.5);

    for (double x = 0; x <= size.width; x++) {
      final y =
          size.height * 0.5 +
          math.sin((x / size.width * 2 * math.pi) + (animValue * 2 * math.pi)) *
              18 +
          math.sin(
                (x / size.width * 4 * math.pi) +
                    (animValue * 2 * math.pi * 1.3),
              ) *
              10;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_WavePainter old) => old.animValue != animValue;
}

class _FishScalePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha(8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    const radius = 28.0;
    const cols = 20;
    const rows = 16;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final cx = col * radius * 1.5 + (row.isOdd ? radius * 0.75 : 0);
        final cy = row * radius * 0.9;
        final rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);
        canvas.drawArc(rect, math.pi, math.pi, false, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_FishScalePainter old) => false;
}
