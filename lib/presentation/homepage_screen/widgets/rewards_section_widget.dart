import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class RewardsSectionWidget extends StatefulWidget {
  const RewardsSectionWidget({super.key});

  @override
  State<RewardsSectionWidget> createState() => _RewardsSectionWidgetState();
}

class _RewardsSectionWidgetState extends State<RewardsSectionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<_RewardItem> _rewards = [
    _RewardItem(
      emoji: '🐟',
      title: 'Fresh Fish Pack',
      desc: '2kg seasonal catch, cleaned & packed',
      value: '₹320 value',
      tag: 'Most Chosen',
      tagColor: AppTheme.secondary,
      imageUrl:
          'https://images.pexels.com/photos/3296434/pexels-photo-3296434.jpeg?auto=compress&cs=tinysrgb&w=400',
      semanticLabel: 'Fresh fish laid out on ice at a coastal Tamil market',
    ),
    _RewardItem(
      emoji: '🫙',
      title: 'Fish Pickle Jar',
      desc: 'Traditional Chettinad-style, 500g',
      value: '₹180 value',
      tag: 'Family Favourite',
      tagColor: AppTheme.primary,
      imageUrl:
          'https://images.pixabay.com/photo/2017/09/16/19/21/pickles-2756467_640.jpg',
      semanticLabel: 'Glass jar of homemade fish pickle with spices',
    ),
    _RewardItem(
      emoji: '🌿',
      title: 'Dry Fish Bundle',
      desc: 'Nethili, Vanjaram & Karuvaadu mix',
      value: '₹240 value',
      tag: 'Coastal Special',
      tagColor: const Color(0xFF2D7A4F),
      imageUrl:
          'https://images.unsplash.com/photo-1544943910-4c1dc44aab44?w=400&auto=format',
      semanticLabel: 'Assorted dry fish spread on a woven mat in sunlight',
    ),
    _RewardItem(
      emoji: '🫒',
      title: 'Cooking Oil Set',
      desc: 'Sesame + Coconut oil, 1L each',
      value: '₹280 value',
      tag: 'Kitchen Essential',
      tagColor: const Color(0xFFB45309),
      imageUrl:
          'https://images.pexels.com/photos/1022385/pexels-photo-1022385.jpeg?auto=compress&cs=tinysrgb&w=400',
      semanticLabel:
          'Two bottles of golden sesame and coconut oil on wooden table',
    ),
    _RewardItem(
      emoji: '🌶️',
      title: 'Spice Bundle',
      desc: 'Turmeric, chilli, coriander & more',
      value: '₹150 value',
      tag: 'Starter Reward',
      tagColor: AppTheme.accent,
      imageUrl:
          'https://images.pexels.com/photos/2802527/pexels-photo-2802527.jpeg?auto=compress&cs=tinysrgb&w=400',
      semanticLabel:
          'Colorful Tamil spices in small bowls on terracotta surface',
    ),
    _RewardItem(
      emoji: '🛒',
      title: 'Grocery Hamper',
      desc: 'Rice, dal, oil & pantry staples',
      value: '₹600 value',
      tag: 'Premium',
      tagColor: AppTheme.primary,
      imageUrl:
          'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400',
      semanticLabel:
          'Wicker basket filled with fresh vegetables and grocery items',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D2E47),
      padding: const EdgeInsets.fromLTRB(20, 52, 20, 52),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(26),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.white.withAlpha(38)),
            ),
            child: Text(
              'HOUSEHOLD REWARDS',
              style: GoogleFonts.dmSans(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.accent,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Real goods for\nyour family.',
            style: GoogleFonts.fraunces(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Not vouchers. Not cashback. Actual household items delivered to your door.',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: Colors.white.withAlpha(166),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 28),
          // Bento grid — varied sizes
          _buildBentoGrid(),
        ],
      ),
    );
  }

  Widget _buildBentoGrid() {
    return Column(
      children: [
        // Row 1: large + small
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: _RewardCard(item: _rewards[0], isLarge: true),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _RewardCard(item: _rewards[1], isLarge: false),
                  const SizedBox(height: 10),
                  _RewardCard(item: _rewards[2], isLarge: false),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Row 2: small + large
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _RewardCard(item: _rewards[3], isLarge: false),
                  const SizedBox(height: 10),
                  _RewardCard(item: _rewards[4], isLarge: false),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: _RewardCard(item: _rewards[5], isLarge: true),
            ),
          ],
        ),
      ],
    );
  }
}

class _RewardCard extends StatefulWidget {
  final _RewardItem item;
  final bool isLarge;
  const _RewardCard({required this.item, required this.isLarge});

  @override
  State<_RewardCard> createState() => _RewardCardState();
}

class _RewardCardState extends State<_RewardCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.isLarge ? 200.0 : 130.0;
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isHovered = true);
        _hoverController.forward();
      },
      onTapUp: (_) {
        setState(() => _isHovered = false);
        _hoverController.reverse();
      },
      onTapCancel: () {
        setState(() => _isHovered = false);
        _hoverController.reverse();
      },
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 - (_hoverController.value * 0.02),
            child: child,
          );
        },
        child: Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white.withAlpha(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Image.network(
                widget.item.imageUrl,
                fit: BoxFit.cover,
                semanticLabel: widget.item.semanticLabel,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.white.withAlpha(20),
                  child: Center(
                    child: Text(
                      widget.item.emoji,
                      style: TextStyle(fontSize: widget.isLarge ? 48 : 32),
                    ),
                  ),
                ),
              ),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withAlpha(184)],
                    stops: const [0.35, 1.0],
                  ),
                ),
              ),
              // Content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: widget.item.tagColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          widget.item.tag,
                          style: GoogleFonts.dmSans(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.item.title,
                        style: GoogleFonts.dmSans(
                          fontSize: widget.isLarge ? 14 : 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.isLarge) ...[
                        const SizedBox(height: 2),
                        Text(
                          widget.item.desc,
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            color: Colors.white.withAlpha(191),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      const SizedBox(height: 3),
                      Text(
                        widget.item.value,
                        style: GoogleFonts.fraunces(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.accent,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RewardItem {
  final String emoji;
  final String title;
  final String desc;
  final String value;
  final String tag;
  final Color tagColor;
  final String imageUrl;
  final String semanticLabel;

  _RewardItem({
    required this.emoji,
    required this.title,
    required this.desc,
    required this.value,
    required this.tag,
    required this.tagColor,
    required this.imageUrl,
    required this.semanticLabel,
  });
}
