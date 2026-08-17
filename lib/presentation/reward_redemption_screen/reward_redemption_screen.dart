import 'package:flutter/material.dart';

import '../../widgets/app_bar_widget.dart';
import './widgets/completed_rewards_widget.dart';
import './widgets/period_filter_widget.dart';
import './widgets/promo_banner_widget.dart';
import './widgets/reward_grid_widget.dart';

class RewardRedemptionScreen extends StatefulWidget {
  const RewardRedemptionScreen({super.key});

  @override
  State<RewardRedemptionScreen> createState() => _RewardRedemptionScreenState();
}

class _RewardRedemptionScreenState extends State<RewardRedemptionScreen> {
  // TODO: Replace with [Riverpod/Bloc] for production
  bool _showBanner = true;
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBarWidget(
        showAvatar: true,
        title: 'PERSONAL',
        avatarUrl:
            'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?w=100',
        avatarSemanticLabel: 'Profile photo of Meena Lakshmi',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Replace with real reward data refresh
          await Future.delayed(const Duration(milliseconds: 800));
        },
        color: theme.colorScheme.primary,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Promo / invite banner (dismissible)
            if (_showBanner)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: PromoBannerWidget(
                    onDismiss: () => setState(() => _showBanner = false),
                  ),
                ),
              ),
            // Transactions-style section header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rewards', style: theme.textTheme.headlineSmall),
                    Text(
                      'AUG 1–28, 2026',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Period filter row
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: PeriodFilterWidget(
                  selected: _selectedFilter,
                  onChanged: (f) => setState(() => _selectedFilter = f),
                ),
              ),
            ),
            // Reward grid
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: RewardGridWidget(filter: _selectedFilter),
              ),
            ),
            // Completed rewards section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Completed', style: theme.textTheme.titleMedium),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'VIEW ALL',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CompletedRewardsWidget(),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
