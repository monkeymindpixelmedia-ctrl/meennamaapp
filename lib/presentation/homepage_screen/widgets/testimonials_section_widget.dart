import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class TestimonialsSectionWidget extends StatefulWidget {
  const TestimonialsSectionWidget({super.key});

  @override
  State<TestimonialsSectionWidget> createState() =>
      _TestimonialsSectionWidgetState();
}

class _TestimonialsSectionWidgetState extends State<TestimonialsSectionWidget>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  late AnimationController _entryController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;

  final List<_Testimonial> _testimonials = [
    _Testimonial(
      name: 'Meena Lakshmi',
      location: 'Rameswaram',
      initials: 'ML',
      avatarColor: Color(0xFFC4622D),
      quote:
          'என் கணவர் மீன்பிடிக்கு போகும்போது, நான் ₹5 போட்டு வைப்பேன். 100 நாளில் ஒரு நல்ல மீன் பொட்டலம் கிடைச்சது.',
      quoteEn:
          'When my husband goes fishing, I save ₹5 daily. After 100 days I got a wonderful fish hamper.',
      plan: '₹5/day',
      reward: 'Fish Hamper',
      daysCompleted: 100,
      rating: 5,
    ),
    _Testimonial(
      name: 'Selvam Arumugam',
      location: 'Nagapattinam',
      initials: 'SA',
      avatarColor: Color(0xFF1B4A6B),
      quote:
          'நான் ₹10 திட்டம் எடுத்தேன். கடைசியில் எண்ணெய் மற்றும் மளிகை பொட்டலம் கிடைச்சது. வீட்டிற்கு மிகவும் பயனுள்ளதாக இருந்தது.',
      quoteEn:
          'I took the ₹10 plan. At the end I received oil and grocery bundle. Very useful for the household.',
      plan: '₹10/day',
      reward: 'Grocery + Oil Bundle',
      daysCompleted: 100,
      rating: 5,
    ),
    _Testimonial(
      name: 'Kavitha Murugan',
      location: 'Tuticorin',
      initials: 'KM',
      avatarColor: Color(0xFF2D7A4F),
      quote:
          'சின்ன சின்னதாக சேமிக்கலாம் என்று தெரியவில்லை. Meenamma app மூலம் ₹2 தினமும் போட்டு, காய வற்றல் பொட்டலம் பெற்றேன்.',
      quoteEn:
          'Didn\'t know I could save so little. Through Meenamma I put ₹2 daily and received a dry fish bundle.',
      plan: '₹2/day',
      reward: 'Dry Fish Bundle',
      daysCompleted: 90,
      rating: 5,
    ),
    _Testimonial(
      name: 'Rajendran Pillai',
      location: 'Kanyakumari',
      initials: 'RP',
      avatarColor: Color(0xFFB45309),
      quote:
          'UPI மூலம் தினமும் பணம் கட்டுவது மிகவும் எளிது. ஒரு நாளும் தவறவில்லை. 60 நாளில் மசாலா பொட்டலம் கிடைத்தது.',
      quoteEn:
          'Paying daily via UPI is very easy. Never missed a day. Got spice bundle in 60 days.',
      plan: '₹1/day',
      reward: 'Spice Bundle',
      daysCompleted: 60,
      rating: 5,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _headerFade = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );
    _headerSlide = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entryController,
            curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
          ),
        );
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _entryController.forward();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundLight,
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeTransition(
            opacity: _headerFade,
            child: SlideTransition(
              position: _headerSlide,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildHeader(),
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Testimonial cards
          SizedBox(
            height: 280,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _testimonials.length,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemBuilder: (context, i) {
                final isActive = _currentPage == i;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutCubic,
                  margin: EdgeInsets.only(
                    top: isActive ? 0 : 16,
                    bottom: isActive ? 0 : 8,
                  ),
                  child: _TestimonialCard(
                    item: _testimonials[i],
                    isActive: isActive,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Navigation row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Pill dots
                Row(
                  children: List.generate(
                    _testimonials.length,
                    (i) => GestureDetector(
                      onTap: () => _pageController.animateToPage(
                        i,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        margin: const EdgeInsets.only(right: 6),
                        width: _currentPage == i ? 24 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: _currentPage == i
                              ? AppTheme.secondary
                              : const Color(0xFFCCCCCC),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // Arrow buttons
                _NavButton(
                  icon: Icons.arrow_back_rounded,
                  onTap: () {
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                      );
                    }
                  },
                  enabled: _currentPage > 0,
                ),
                const SizedBox(width: 8),
                _NavButton(
                  icon: Icons.arrow_forward_rounded,
                  onTap: () {
                    if (_currentPage < _testimonials.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                      );
                    }
                  },
                  enabled: _currentPage < _testimonials.length - 1,
                ),
              ],
            ),
          ),
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
            color: AppTheme.secondaryContainer,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            'FAMILY STORIES',
            style: GoogleFonts.dmSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.secondary,
              letterSpacing: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Tamil families\ntrust Meenamma.',
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
          'Real stories. Real rewards. Coastal Tamil Nadu.',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: const Color(0xFF6A6A6A),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _NavButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;
  const _NavButton({
    required this.icon,
    required this.onTap,
    required this.enabled,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton>
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
      end: 0.9,
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
        if (widget.enabled) widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: widget.enabled ? AppTheme.primary : const Color(0xFFE8E4DF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            widget.icon,
            size: 18,
            color: widget.enabled ? Colors.white : const Color(0xFFBBBBBB),
          ),
        ),
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final _Testimonial item;
  final bool isActive;
  const _TestimonialCard({required this.item, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.surfaceLight : const Color(0xFFF8F5F0),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isActive ? const Color(0xFFE0DBD4) : const Color(0xFFEEEBE6),
          width: 1.5,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppTheme.primary.withAlpha(18),
                  blurRadius: 28,
                  offset: const Offset(0, 8),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author row at top
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: item.avatarColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    item.initials,
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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
                      item.name,
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    Text(
                      item.location,
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: const Color(0xFF8A8A8A),
                      ),
                    ),
                  ],
                ),
              ),
              // Stars
              Row(
                children: List.generate(
                  item.rating,
                  (_) => const Icon(
                    Icons.star_rounded,
                    size: 13,
                    color: Color(0xFFD4A017),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Tamil quote
          Text(
            '\\u201C${item.quote}\\u201D',
            style: GoogleFonts.dmSans(
              fontSize: 13,
              color: const Color(0xFF3A3A3A),
              height: 1.65,
              fontStyle: FontStyle.italic,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            item.quoteEn,
            style: GoogleFonts.dmSans(
              fontSize: 11,
              color: const Color(0xFF9A9A9A),
              height: 1.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          // Plan + reward chips
          Row(
            children: [
              _InfoChip(label: item.plan, color: item.avatarColor),
              const SizedBox(width: 6),
              Expanded(
                child: _InfoChip(
                  label: '🎁 ${item.reward}',
                  color: AppTheme.primary,
                  isLight: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isLight;
  const _InfoChip({
    required this.label,
    required this.color,
    this.isLight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isLight ? color.withAlpha(18) : color,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isLight ? color : Colors.white,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _Testimonial {
  final String name;
  final String location;
  final String initials;
  final Color avatarColor;
  final String quote;
  final String quoteEn;
  final String plan;
  final String reward;
  final int daysCompleted;
  final int rating;

  const _Testimonial({
    required this.name,
    required this.location,
    required this.initials,
    required this.avatarColor,
    required this.quote,
    required this.quoteEn,
    required this.plan,
    required this.reward,
    required this.daysCompleted,
    required this.rating,
  });
}
