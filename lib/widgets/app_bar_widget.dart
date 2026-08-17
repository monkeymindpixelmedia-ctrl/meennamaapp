import 'package:flutter/material.dart';

import '../core/app_export.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showAvatar;
  final String? avatarUrl;
  final String? avatarSemanticLabel;
  final VoidCallback? onAvatarTap;
  final Color? backgroundColor;
  final double elevation;

  const AppBarWidget({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.showAvatar = false,
    this.avatarUrl,
    this.avatarSemanticLabel,
    this.onAvatarTap,
    this.backgroundColor,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.scaffoldBackgroundColor;

    if (showAvatar) {
      return Container(
        color: bg,
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: kToolbarHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Left icon slot
                  _IconSlot(
                    child:
                        leading ??
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {},
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomIconWidget(
                              iconName: 'grid_view',
                              color: theme.colorScheme.onSurface,
                              size: 18,
                            ),
                          ),
                        ),
                  ),
                  // Center avatar + account name
                  Expanded(
                    child: GestureDetector(
                      onTap: onAvatarTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: theme.colorScheme.primaryContainer,
                            child: avatarUrl != null
                                ? ClipOval(
                                    child: CustomImageWidget(
                                      imageUrl: avatarUrl!,
                                      width: 32,
                                      height: 32,
                                      fit: BoxFit.cover,
                                      semanticLabel:
                                          avatarSemanticLabel ??
                                          'User profile photo',
                                    ),
                                  )
                                : CustomIconWidget(
                                    iconName: 'person',
                                    color: theme.colorScheme.primary,
                                    size: 16,
                                  ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            title ?? 'PERSONAL',
                            style: theme.textTheme.labelMedium?.copyWith(
                              letterSpacing: 1.2,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Right icon slot
                  _IconSlot(
                    child: actions?.isNotEmpty == true
                        ? actions!.first
                        : InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {},
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color:
                                    theme.colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomIconWidget(
                                iconName: 'notifications_outlined',
                                color: theme.colorScheme.onSurface,
                                size: 18,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return AppBar(
      backgroundColor: bg,
      elevation: elevation,
      scrolledUnderElevation: 1,
      title: title != null
          ? Text(
              title!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            )
          : null,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);
}

class _IconSlot extends StatelessWidget {
  final Widget child;
  const _IconSlot({required this.child});

  @override
  Widget build(BuildContext context) => SizedBox(width: 44, child: child);
}
