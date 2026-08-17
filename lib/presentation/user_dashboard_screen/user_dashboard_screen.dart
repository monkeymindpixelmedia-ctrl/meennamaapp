import 'package:flutter/material.dart';

import '../../widgets/app_bar_widget.dart';
import './widgets/balance_hero_widget.dart';
import './widgets/metric_grid_widget.dart';
import './widgets/payment_history_widget.dart';
import './widgets/period_selector_widget.dart';
import './widgets/plan_cards_widget.dart';
import './widgets/streak_banner_widget.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  // TODO: Replace with [Riverpod/Bloc] for production
  String _selectedPeriod = 'MONTH';
  bool _isRefreshing = false;

  Future<void> _onRefresh() async {
    setState(() => _isRefreshing = true);
    // TODO: Replace with real data refresh
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) setState(() => _isRefreshing = false);
  }

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
        avatarSemanticLabel:
            'Profile photo of Meena Lakshmi, Tamil woman in her 30s',
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: theme.colorScheme.primary,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Balance hero section
            SliverToBoxAdapter(child: BalanceHeroWidget()),
            // Period selector
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: PeriodSelectorWidget(
                  selected: _selectedPeriod,
                  onChanged: (p) => setState(() => _selectedPeriod = p),
                ),
              ),
            ),
            // Plan cards horizontal scroll
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: PlanCardsWidget(period: _selectedPeriod),
              ),
            ),
            // Metric grid
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: MetricGridWidget(),
              ),
            ),
            // Streak banner
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: StreakBannerWidget(),
              ),
            ),
            // Payment history header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payment History', style: theme.textTheme.titleMedium),
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
              ),
            ),
            // Payment history list
            SliverToBoxAdapter(
              child: PaymentHistoryWidget(period: _selectedPeriod),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
