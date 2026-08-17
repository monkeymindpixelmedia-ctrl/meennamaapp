import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import './widgets/cta_footer_widget.dart';
import './widgets/faq_section_widget.dart';
import './widgets/hero_section_widget.dart';
import './widgets/plans_section_widget.dart';
import './widgets/rewards_section_widget.dart';
import './widgets/testimonials_section_widget.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isNavScrolled = false;
  late AnimationController _navAnimController;

  @override
  void initState() {
    super.initState();
    _navAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 80;
      if (scrolled != _isNavScrolled) {
        setState(() => _isNavScrolled = scrolled);
        if (scrolled) {
          _navAnimController.forward();
        } else {
          _navAnimController.reverse();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _navAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      extendBodyBehindAppBar: true,
      appBar: _buildNavBar(context),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: const Column(
          children: [
            HeroSectionWidget(),
            PlansSectionWidget(),
            RewardsSectionWidget(),
            TestimonialsSectionWidget(),
            FaqSectionWidget(),
            CtaFooterWidget(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildNavBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: _isNavScrolled
              ? AppTheme.backgroundLight.withAlpha(248)
              : Colors.transparent,
          boxShadow: _isNavScrolled
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withAlpha(15),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
          border: _isNavScrolled
              ? Border(
                  bottom: BorderSide(
                    color: AppTheme.primary.withAlpha(15),
                    width: 1,
                  ),
                )
              : null,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                // Logo
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _isNavScrolled
                            ? AppTheme.primary
                            : Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(11),
                        border: _isNavScrolled
                            ? null
                            : Border.all(color: Colors.white.withAlpha(60)),
                      ),
                      child: Center(
                        child: Text(
                          'மீ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Text(
                      'Meenamma',
                      style: GoogleFonts.fraunces(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _isNavScrolled ? AppTheme.primary : Colors.white,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Login text button
                TextButton(
                  onPressed: () => context.go(AppRoutes.signUpLogin),
                  style: TextButton.styleFrom(
                    foregroundColor: _isNavScrolled
                        ? AppTheme.primary
                        : Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                _NavJoinButton(
                  isScrolled: _isNavScrolled,
                  onTap: () => context.go(AppRoutes.signUpLogin),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavJoinButton extends StatefulWidget {
  final bool isScrolled;
  final VoidCallback onTap;
  const _NavJoinButton({required this.isScrolled, required this.onTap});

  @override
  State<_NavJoinButton> createState() => _NavJoinButtonState();
}

class _NavJoinButtonState extends State<_NavJoinButton>
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
      end: 0.93,
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: widget.isScrolled
                ? AppTheme.secondary
                : Colors.white.withAlpha(30),
            borderRadius: BorderRadius.circular(11),
            border: widget.isScrolled
                ? null
                : Border.all(color: Colors.white.withAlpha(60)),
          ),
          child: Text(
            'Join Now',
            style: GoogleFonts.dmSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
