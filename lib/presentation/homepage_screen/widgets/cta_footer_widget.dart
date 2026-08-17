import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_theme.dart';

class CtaFooterWidget extends StatefulWidget {
  const CtaFooterWidget({super.key});

  @override
  State<CtaFooterWidget> createState() => _CtaFooterWidgetState();
}

class _CtaFooterWidgetState extends State<CtaFooterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [_buildCtaSection(context), _buildFooter()]);
  }

  Widget _buildCtaSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(28)),
      child: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0D2E47),
                  Color(0xFF1B4A6B),
                  Color(0xFF1E5578),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
          // Subtle pattern overlay
          Positioned.fill(child: CustomPaint(painter: _CtaPatternPainter())),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 36, 28, 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Eyebrow
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withAlpha(40),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppTheme.accent.withAlpha(80)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('🪔', style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 6),
                      Text(
                        '2,400+ families saving daily',
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.accent,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Headline — left-aligned, not centered
                Text(
                  'Start your\nkudam today.',
                  style: GoogleFonts.fraunces(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.1,
                    letterSpacing: -1.0,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Pay ₹1 to ₹10 a day.\nComplete your cycle. Receive something real.',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: Colors.white.withAlpha(190),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 28),
                // Asymmetric button layout
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _CtaButton(
                        label: 'Create Free Account',
                        isPrimary: true,
                        onTap: () => context.go(AppRoutes.signUpLogin),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: _CtaButton(
                        label: 'Login',
                        isPrimary: false,
                        onTap: () => context.go(AppRoutes.signUpLogin),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Social proof row
                Row(
                  children: [
                    _ProofChip(label: '🐟 Fish', color: AppTheme.secondary),
                    const SizedBox(width: 8),
                    _ProofChip(label: '🫒 Oil', color: const Color(0xFFB45309)),
                    const SizedBox(width: 8),
                    _ProofChip(
                      label: '🌶️ Spices',
                      color: const Color(0xFF2D7A4F),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: const Color(0xFF0D2E47),
      padding: const EdgeInsets.fromLTRB(20, 36, 20, 36),
      child: Column(
        children: [
          // Logo + tagline
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(20),
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: Colors.white.withAlpha(30)),
                ),
                child: const Center(
                  child: Text(
                    'மீ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meenamma',
                      style: GoogleFonts.fraunces(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Daily savings for Tamil families.\nCoastal Tamil Nadu.',
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        color: Colors.white.withAlpha(120),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Container(height: 1, color: Colors.white.withAlpha(20)),
          const SizedBox(height: 20),
          // Links + copyright in one row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    _FooterLink(label: 'How it works'),
                    _FooterLink(label: 'Plans'),
                    _FooterLink(label: 'Rewards'),
                    _FooterLink(label: 'FAQs'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                '© 2026 Meenamma',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: Colors.white.withAlpha(80),
                ),
              ),
              const Spacer(),
              Text(
                '🐟 Made with love',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: Colors.white.withAlpha(80),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CtaButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;
  const _CtaButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton>
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
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? AppTheme.secondary
                : Colors.white.withAlpha(20),
            borderRadius: BorderRadius.circular(14),
            border: widget.isPrimary
                ? null
                : Border.all(color: Colors.white.withAlpha(50)),
            boxShadow: widget.isPrimary
                ? [
                    BoxShadow(
                      color: AppTheme.secondary.withAlpha(80),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              widget.label,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProofChip extends StatelessWidget {
  final String label;
  final Color color;
  const _ProofChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.white.withAlpha(200),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  const _FooterLink({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.dmSans(
        fontSize: 12,
        color: Colors.white.withAlpha(140),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _CtaPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha(6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const spacing = 32.0;
    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paint..style = PaintingStyle.fill);
      }
    }
  }

  @override
  bool shouldRepaint(_CtaPatternPainter old) => false;
}
