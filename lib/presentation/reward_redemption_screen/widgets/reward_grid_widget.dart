import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/status_badge_widget.dart';

class RewardGridWidget extends StatelessWidget {
  final String filter;
  const RewardGridWidget({super.key, required this.filter});

  static const List<Map<String, dynamic>> _rewardMaps = [
    {
      'id': 'r1',
      'name': 'Family Fish Hamper',
      'category': 'Fish',
      'value': '₹500',
      'daysLeft': 62,
      'status': 'available',
      'emoji': '🐠',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1a8f13d41-1777288389786.png',
      'semanticLabel':
          'Fresh colorful fish arranged on a wooden board with herbs and lemon',
      'description': 'Fresh catch — seer fish, pomfret & prawns',
    },
    {
      'id': 'r2',
      'name': 'Dry Fish Bundle',
      'category': 'Fish',
      'value': '₹200',
      'daysLeft': 0,
      'status': 'available',
      'emoji': '🐟',
      'imageUrl':
          'https://images.unsplash.com/photo-1612426357506-8b66a851fbe6',
      'semanticLabel':
          'Assorted dried fish pieces arranged on a bamboo mat in sunlight',
      'description': 'Nethili & vaalai dry fish, sun-dried',
    },
    {
      'id': 'r3',
      'name': 'Fish Pickle Jar',
      'category': 'Fish',
      'value': '₹150',
      'daysLeft': 0,
      'status': 'available',
      'emoji': '🫙',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1e000ed55-1771908887403.png',
      'semanticLabel':
          'Glass jar of homemade fish pickle with red chili and spices on a rustic surface',
      'description': 'Traditional Chettinad fish pickle, 500g',
    },
    {
      'id': 'r4',
      'name': 'Cooking Oil Pack',
      'category': 'Oil & Spice',
      'value': '₹300',
      'daysLeft': 20,
      'status': 'available',
      'emoji': '🫙',
      'imageUrl':
          'https://images.unsplash.com/photo-1450647506948-357b397daed2',
      'semanticLabel':
          'Bottles of golden sesame and groundnut oil on a wooden kitchen shelf',
      'description': 'Cold-pressed sesame oil + groundnut oil, 1L each',
    },
    {
      'id': 'r5',
      'name': 'Spice Bundle',
      'category': 'Oil & Spice',
      'value': '₹100',
      'daysLeft': 0,
      'status': 'available',
      'emoji': '🌶️',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_19e152a00-1778413171900.png',
      'semanticLabel':
          'Colorful Indian spices in small clay bowls arranged on a terracotta surface',
      'description': 'Kuzhambu mix, sambar powder, rasam powder',
    },
    {
      'id': 'r6',
      'name': 'Premium Grocery Box',
      'category': 'Grocery',
      'value': '₹1,000',
      'daysLeft': 100,
      'status': 'active',
      'emoji': '🛒',
      'imageUrl':
          'https://images.unsplash.com/photo-1680413083024-448b2ecb74fb',
      'semanticLabel':
          'Assorted fresh vegetables, lentils and spices arranged in a wooden crate',
      'description': 'Rice, dal, oil, spices, veggies & essentials',
    },
  ];

  List<Map<String, dynamic>> _filtered() {
    if (filter == 'All') return _rewardMaps;
    return _rewardMaps.where((r) => r['category'] == filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final filtered = _filtered();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 3 : 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.72,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, i) => _RewardCard(reward: filtered[i]),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final Map<String, dynamic> reward;
  const _RewardCard({required this.reward});

  BadgeStatus _statusFromString(String s) {
    switch (s) {
      case 'available':
        return BadgeStatus.available;
      case 'active':
        return BadgeStatus.active;
      case 'completed':
        return BadgeStatus.completed;
      default:
        return BadgeStatus.active;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final daysLeft = reward['daysLeft'] as int;
    final isReady = daysLeft == 0;

    return GestureDetector(
      onTap: () => _showRedemptionSheet(context, reward),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full-bleed image top — Image Hero anatomy locked
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  CustomImageWidget(
                    imageUrl: reward['imageUrl'] as String,
                    width: double.infinity,
                    height: 110,
                    fit: BoxFit.cover,
                    semanticLabel: reward['semanticLabel'] as String,
                  ),
                  if (!isReady)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(140),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          '$daysLeft days',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  if (isReady)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D7A4F),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text(
                          'Ready!',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Info below image
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward['name'] as String,
                    style: theme.textTheme.titleSmall?.copyWith(fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    reward['description'] as String,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        reward['value'] as String,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                      Text(
                        reward['emoji'] as String,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // CTA button
                  SizedBox(
                    width: double.infinity,
                    height: 34,
                    child: ElevatedButton(
                      onPressed: isReady
                          ? () => _showRedemptionSheet(context, reward)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isReady
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surfaceContainerHighest,
                        foregroundColor: isReady
                            ? Colors.white
                            : theme.colorScheme.onSurfaceVariant,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Text(isReady ? 'Redeem Now' : 'In Progress'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRedemptionSheet(BuildContext context, Map<String, dynamic> reward) {
    final daysLeft = reward['daysLeft'] as int;
    if (daysLeft > 0) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _RedemptionBottomSheet(reward: reward),
    );
  }
}

class _RedemptionBottomSheet extends StatefulWidget {
  final Map<String, dynamic> reward;
  const _RedemptionBottomSheet({required this.reward});

  @override
  State<_RedemptionBottomSheet> createState() => _RedemptionBottomSheetState();
}

class _RedemptionBottomSheetState extends State<_RedemptionBottomSheet> {
  // TODO: Replace with [Riverpod/Bloc] for production
  bool _isDelivery = true;
  final _addressCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.92,
      minChildSize: 0.5,
      builder: (_, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFDDDDDD),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Reward image + name
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CustomImageWidget(
                        imageUrl: widget.reward['imageUrl'] as String,
                        width: double.infinity,
                        height: 160,
                        fit: BoxFit.cover,
                        semanticLabel: widget.reward['semanticLabel'] as String,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.reward['name'] as String,
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.reward['description'] as String,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Delivery / Pickup toggle
                    Text(
                      'How would you like to receive it?',
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isDelivery = true),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: _isDelivery
                                    ? theme.colorScheme.primaryContainer
                                    : theme.colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: _isDelivery
                                      ? theme.colorScheme.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  CustomIconWidget(
                                    iconName: 'local_shipping_outlined',
                                    color: _isDelivery
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.onSurfaceVariant,
                                    size: 24,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Home Delivery',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: _isDelivery
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isDelivery = false),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: !_isDelivery
                                    ? theme.colorScheme.primaryContainer
                                    : theme.colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: !_isDelivery
                                      ? theme.colorScheme.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  CustomIconWidget(
                                    iconName: 'storefront_outlined',
                                    color: !_isDelivery
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.onSurfaceVariant,
                                    size: 24,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Pickup',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: !_isDelivery
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_isDelivery) ...[
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _addressCtrl,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Delivery Address',
                          hintText: 'Door no., Street, Area, City, Pincode',
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            size: 20,
                          ),
                          alignLabelWithHint: true,
                        ),
                      ),
                    ] else ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'store',
                              color: theme.colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Meenamma Pickup Point',
                                    style: theme.textTheme.labelMedium
                                        ?.copyWith(
                                          color: theme.colorScheme.onSurface,
                                        ),
                                  ),
                                  Text(
                                    'Available from Aug 15, 2026 · 9AM–6PM',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 28),
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                setState(() => _isLoading = true);
                                // TODO: Replace with real reward redemption API call
                                await Future.delayed(
                                  const Duration(milliseconds: 1400),
                                );
                                if (!context.mounted) return;
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '🎉 ${widget.reward['name']} redeemed successfully!',
                                    ),
                                    backgroundColor: const Color(0xFF2D7A4F),
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              },
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomIconWidget(
                                    iconName: 'redeem',
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Confirm Redemption'),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'Delivery within 3–5 working days after confirmation',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
