import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class FaqSectionWidget extends StatefulWidget {
  const FaqSectionWidget({super.key});

  @override
  State<FaqSectionWidget> createState() => _FaqSectionWidgetState();
}

class _FaqSectionWidgetState extends State<FaqSectionWidget>
    with TickerProviderStateMixin {
  int? _openIndex;
  late List<AnimationController> _itemControllers;
  late List<Animation<double>> _itemAnims;

  final List<_FaqItem> _faqs = [
    _FaqItem(
      q: 'How does Meenamma work?',
      a: 'You choose a daily plan (₹1, ₹2, ₹5, or ₹10), pay every day via UPI, and after completing your cycle you receive a real household reward — fish, oil, spices, or groceries — delivered to your home.',
      icon: '🪔',
    ),
    _FaqItem(
      q: 'What happens if I miss a payment?',
      a: 'Missing a day pauses your streak but doesn\'t cancel your plan. You can resume the next day. We send daily reminders to help you stay on track.',
      icon: '📅',
    ),
    _FaqItem(
      q: 'How do I receive my reward?',
      a: 'Once you complete your cycle, you can choose your reward from available options. Delivery is arranged to your registered address, or you can opt for local pickup if available in your area.',
      icon: '🎁',
    ),
    _FaqItem(
      q: 'Is my UPI payment secure?',
      a: 'Yes. All payments are processed through verified UPI infrastructure. We never store your UPI credentials. Each transaction generates a unique reference ID for your records.',
      icon: '🔒',
    ),
    _FaqItem(
      q: 'Can I change my plan mid-cycle?',
      a: 'Plan changes take effect from the next cycle. Your current cycle continues at the original plan amount. You can upgrade or downgrade anytime from your dashboard.',
      icon: '🔄',
    ),
    _FaqItem(
      q: 'Which areas do you deliver to?',
      a: 'We currently serve coastal Tamil Nadu — Rameswaram, Nagapattinam, Tuticorin, Kanyakumari, and surrounding areas. We\'re expanding to more districts soon.',
      icon: '📍',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _itemControllers = List.generate(
      _faqs.length,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 320),
      ),
    );
    _itemAnims = _itemControllers
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeOutCubic))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _itemControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _toggle(int i) {
    if (_openIndex == i) {
      _itemControllers[i].reverse();
      setState(() => _openIndex = null);
    } else {
      if (_openIndex != null) {
        _itemControllers[_openIndex!].reverse();
      }
      _itemControllers[i].forward();
      setState(() => _openIndex = i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F5F0),
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          ...List.generate(_faqs.length, (i) => _buildFaqItem(i)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppTheme.accentContainer,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            'FREQUENTLY ASKED',
            style: GoogleFonts.dmSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.warning,
              letterSpacing: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Questions families\nusually ask.',
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
          'Everything you need to know before you start.',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: const Color(0xFF6A6A6A),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildFaqItem(int i) {
    final isOpen = _openIndex == i;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _FaqItemWidget(
        faq: _faqs[i],
        isOpen: isOpen,
        anim: _itemAnims[i],
        onTap: () => _toggle(i),
        index: i,
      ),
    );
  }
}

class _FaqItemWidget extends StatefulWidget {
  final _FaqItem faq;
  final bool isOpen;
  final Animation<double> anim;
  final VoidCallback onTap;
  final int index;

  const _FaqItemWidget({
    required this.faq,
    required this.isOpen,
    required this.anim,
    required this.onTap,
    required this.index,
  });

  @override
  State<_FaqItemWidget> createState() => _FaqItemWidgetState();
}

class _FaqItemWidgetState extends State<_FaqItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressCtrl;
  late Animation<double> _pressScale;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _pressScale = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _pressCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressCtrl.forward(),
      onTapUp: (_) {
        _pressCtrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _pressCtrl.reverse(),
      child: AnimatedBuilder(
        animation: Listenable.merge([_pressCtrl, widget.anim]),
        builder: (context, child) {
          return Transform.scale(
            scale: _pressScale.value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                color: widget.isOpen ? AppTheme.primary : AppTheme.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.isOpen
                      ? AppTheme.primary
                      : const Color(0xFFE8E4DF),
                  width: 1.5,
                ),
                boxShadow: widget.isOpen
                    ? [
                        BoxShadow(
                          color: AppTheme.primary.withAlpha(40),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : [],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon badge
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: widget.isOpen
                                ? Colors.white.withAlpha(30)
                                : AppTheme.surfaceVariantLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              widget.faq.icon,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              widget.faq.q,
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: widget.isOpen
                                    ? Colors.white
                                    : const Color(0xFF1A1A1A),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: AnimatedRotation(
                            turns: widget.isOpen ? 0.5 : 0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: widget.isOpen
                                    ? Colors.white.withAlpha(30)
                                    : const Color(0xFFF0EDE8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 18,
                                color: widget.isOpen
                                    ? Colors.white
                                    : const Color(0xFF6A6A6A),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizeTransition(
                      sizeFactor: widget.anim,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14, left: 46),
                        child: Text(
                          widget.faq.a,
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            color: Colors.white.withAlpha(210),
                            height: 1.7,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FaqItem {
  final String q;
  final String a;
  final String icon;
  _FaqItem({required this.q, required this.a, required this.icon});
}
