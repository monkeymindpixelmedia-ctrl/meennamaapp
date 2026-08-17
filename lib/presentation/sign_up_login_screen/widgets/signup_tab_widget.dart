import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class SignupTabWidget extends StatefulWidget {
  final VoidCallback onSuccess;
  const SignupTabWidget({super.key, required this.onSuccess});

  @override
  State<SignupTabWidget> createState() => _SignupTabWidgetState();
}

class _SignupTabWidgetState extends State<SignupTabWidget> {
  // TODO: Replace with [Riverpod/Bloc] for production
  int _currentStep = 0;
  final _step1Key = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _areaCtrl = TextEditingController();
  int _selectedPlan = 2; // index into plans list
  bool _isLoading = false;

  static const List<Map<String, dynamic>> _plans = [
    {
      'amount': 1,
      'days': 100,
      'total': 100,
      'reward': 'Spice Bundle',
      'icon': '🌶️',
    },
    {
      'amount': 2,
      'days': 100,
      'total': 200,
      'reward': 'Dry Fish Pack',
      'icon': '🐟',
    },
    {
      'amount': 5,
      'days': 100,
      'total': 500,
      'reward': 'Family Fish Hamper',
      'icon': '🐠',
    },
    {
      'amount': 10,
      'days': 100,
      'total': 1000,
      'reward': 'Premium Grocery Box',
      'icon': '🛒',
    },
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _areaCtrl.dispose();
    super.dispose();
  }

  Widget _buildStepIndicator(BuildContext context) {
    final theme = Theme.of(context);
    const labels = ['Details', 'Plan', 'Payment'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: List.generate(3, (i) {
          final isDone = i < _currentStep;
          final isActive = i == _currentStep;
          return Expanded(
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isDone || isActive
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isDone
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 14,
                          )
                        : Text(
                            '${i + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isActive
                                  ? Colors.white
                                  : theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    labels[i],
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isActive
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (i < 2)
                  Expanded(
                    child: Container(
                      height: 1.5,
                      color: i < _currentStep
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outlineVariant,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStep1(BuildContext context) {
    return Form(
      key: _step1Key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Tell us about you',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _nameCtrl,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person_outline_rounded, size: 20),
            ),
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Enter your name' : null,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Mobile Number',
              prefixText: '+91 ',
              prefixIcon: Icon(Icons.phone_outlined, size: 20),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Enter mobile number';
              if (v.trim().length < 10) return 'Enter valid 10-digit number';
              return null;
            },
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Email (optional)',
              prefixIcon: Icon(Icons.email_outlined, size: 20),
            ),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _areaCtrl,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Delivery Area / City',
              prefixIcon: Icon(Icons.location_on_outlined, size: 20),
              hintText: 'e.g. Chennai, Madurai, Coimbatore',
            ),
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Enter your area' : null,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                if (_step1Key.currentState!.validate()) {
                  setState(() => _currentStep = 1);
                }
              },
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Choose your plan', style: theme.textTheme.titleLarge),
        const SizedBox(height: 6),
        Text(
          'Select how much you can save daily',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        ...List.generate(_plans.length, (i) {
          final plan = _plans[i];
          final isSelected = _selectedPlan == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedPlan = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primaryContainer
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outline,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: theme.colorScheme.primary.withAlpha(31),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Text(
                    plan['icon'] as String,
                    style: const TextStyle(fontSize: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${plan['amount']}/day',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${plan['days']} days · Total ₹${plan['total']}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        plan['reward'] as String,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 4),
                      if (isSelected)
                        Icon(
                          Icons.check_circle_rounded,
                          color: theme.colorScheme.primary,
                          size: 18,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _currentStep = 0),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () => setState(() => _currentStep = 2),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep3(BuildContext context) {
    final theme = Theme.of(context);
    final plan = _plans[_selectedPlan];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Payment Setup', style: theme.textTheme.titleLarge),
        const SizedBox(height: 6),
        Text(
          'Connect your UPI for daily auto-debit',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        // Plan summary card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _SummaryRow(
                'Plan',
                '₹${plan['amount']}/day for ${plan['days']} days',
              ),
              const SizedBox(height: 8),
              _SummaryRow('Total commitment', '₹${plan['total']}'),
              const SizedBox(height: 8),
              _SummaryRow('Reward', '${plan['icon']} ${plan['reward']}'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // UPI ID field
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'UPI ID',
            hintText: 'yourname@upi',
            prefixIcon: Icon(Icons.account_balance_wallet_outlined, size: 20),
            helperText: 'e.g. 9876543210@paytm or name@gpay',
          ),
        ),
        const SizedBox(height: 14),
        // Mandate consent
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: theme.colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomIconWidget(
                iconName: 'info_outline',
                color: theme.colorScheme.tertiary,
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'A daily UPI auto-debit mandate of ₹${plan['amount']} will be set up. You can pause anytime.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onTertiaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: _isLoading
                ? null
                : () async {
                    setState(() => _isLoading = true);
                    // TODO: Replace with real UPI mandate setup
                    await Future.delayed(const Duration(milliseconds: 1400));
                    if (!mounted) return;
                    setState(() => _isLoading = false);
                    widget.onSuccess();
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
                : const Text('Start My Subscription'),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => setState(() => _currentStep = 1),
          child: const Text('Back'),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text.rich(
            TextSpan(
              text: 'By continuing you agree to our ',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              children: [
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildStepIndicator(context),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          ),
          child: KeyedSubtree(
            key: ValueKey(_currentStep),
            child: _currentStep == 0
                ? _buildStep1(context)
                : _currentStep == 1
                ? _buildStep2(context)
                : _buildStep3(context),
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}
