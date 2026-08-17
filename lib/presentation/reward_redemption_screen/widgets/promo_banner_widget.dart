import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class PromoBannerWidget extends StatelessWidget {
  final VoidCallback onDismiss;
  const PromoBannerWidget({super.key, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Extracted anatomy: rounded card + title + subtitle + CTA + close X + background image
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B4A6B).withAlpha(46),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: CustomImageWidget(
                imageUrl:
                    'https://images.pixabay.com/photo/2016/03/05/22/10/fish-1238246_1280.jpg',
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
                semanticLabel:
                    'Colorful fresh fish arranged on ice at a Tamil Nadu fish market',
              ),
            ),
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF1B4A6B).withAlpha(217),
                      const Color(0xFF1B4A6B).withAlpha(102),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Invite friends',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'GET ₹25 FOR EACH FRIEND',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withAlpha(204),
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // CTA button — extracted anatomy: white pill button
                        Container(
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomIconWidget(
                                    iconName: 'add',
                                    color: const Color(0xFF1B4A6B),
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'INVITE NOW',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1B4A6B),
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Close X button
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: onDismiss,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: 'close',
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
