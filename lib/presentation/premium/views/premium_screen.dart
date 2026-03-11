import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/floating_navbar.dart';

// Design tokens (match React PremiumScreen)
const Color _bg = Color(0xFF0A0A0F);
const Color _card = Color(0xFF1A1A22);
const Color _cardBorder = Color(0xFF2A2A32);
const Color _gold = Color(0xFFD4AF37);
const Color _goldLight = Color(0xFFF6D365);
const Color _green = Color(0xFF10B981);
const Color _muted = Color(0xFF8A8A92);
const Color _textSoft = Color(0xFFCFCFCF);
const Color _bgDark = Color(0xFF0A0A0F);

/// Plan model for pricing cards. Matches React plans array.
class PremiumPlan {
  const PremiumPlan({
    required this.name,
    required this.price,
    required this.period,
    required this.popular,
    required this.description,
    this.badge,
    this.savings,
  });

  final String name;
  final String price;
  final String period;
  final bool popular;
  final String description;
  final String? badge;
  final String? savings;
}

const List<PremiumPlan> _plans = [
  PremiumPlan(
    name: 'Monthly',
    price: '৳199',
    period: '/month',
    popular: false,
    description: 'Full protection, billed monthly',
  ),
  PremiumPlan(
    name: 'Yearly',
    price: '৳1,499',
    period: '/year',
    popular: true,
    savings: 'Save ৳889',
    description: 'Best value, ৳125/month',
  ),
  PremiumPlan(
    name: 'Family Plan',
    price: '৳249',
    period: '/month',
    popular: false,
    description: 'Up to 5 family members',
    badge: 'NEW',
  ),
];

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  int _selectedPlanIndex = 1; // Yearly = most popular, default selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          _buildBackgroundGlows(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  _buildHeader(),
                  const SizedBox(height: 24),
                  const _PremiumHeroCard(),
                  const SizedBox(height: 24),
                  _buildPricingSection(),
                  const SizedBox(height: 24),
                  _buildSubscribeButtonSection(),
                  const SizedBox(height: 24),
                  const _TrustStatsWidget(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          const FloatingNavBar(),
        ],
      ),
    );
  }

  Widget _buildBackgroundGlows() {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: 80,
            left: -64,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _gold.withValues(alpha: 0.05),
                boxShadow: [
                  BoxShadow(
                    color: _gold.withValues(alpha: 0.05),
                    blurRadius: 80,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 160,
            right: -64,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _goldLight.withValues(alpha: 0.05),
                boxShadow: [
                  BoxShadow(
                    color: _goldLight.withValues(alpha: 0.05),
                    blurRadius: 80,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.offNamed('/dashboard'),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _cardBorder),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_rounded, color: _muted, size: 24),
          ),
        ),
        const Text(
          'Premium',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildPricingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Choose Your Plan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(_plans.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _PlanCardWidget(
              plan: _plans[index],
              isSelected: _selectedPlanIndex == index,
              onTap: () => setState(() => _selectedPlanIndex = index),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSubscribeButtonSection() {
    return Column(
      children: [
        _SubscriptionButton(
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        Text(
          'Cancel anytime • No commitment • 15-day money-back guarantee',
          style: TextStyle(color: _muted, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _PremiumHeroCard extends StatelessWidget {
  const _PremiumHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_card, _cardBorder],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: _gold.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_gold, _goldLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.workspace_premium_rounded, color: _bgDark, size: 40),
          ),
          const SizedBox(height: 24),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              children: [
                const TextSpan(text: 'Upgrade to Premium\n'),
                TextSpan(
                  text: 'Protection',
                  style: TextStyle(color: _gold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Ultimate safety with exclusive features\n24/7 priority emergency response',
            style: TextStyle(color: _textSoft, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _gold.withValues(alpha: 0.2),
                  _goldLight.withValues(alpha: 0.2),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: _gold.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.schedule_rounded, color: _gold, size: 18),
                const SizedBox(width: 8),
                Text(
                  '15-Day Free Trial • 12 Days Left',
                  style: TextStyle(
                    color: _gold,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCardWidget extends StatelessWidget {
  const _PlanCardWidget({
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  final PremiumPlan plan;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: plan.popular
              ? LinearGradient(
                  colors: [
                    _gold.withValues(alpha: 0.1),
                    _goldLight.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: plan.popular ? null : _card.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: plan.popular
                ? _gold.withValues(alpha: 0.5)
                : _gold.withValues(alpha: 0.2),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              plan.price,
                              style: const TextStyle(
                                color: _gold,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              plan.period,
                              style: TextStyle(color: _muted, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          plan.description,
                          style: TextStyle(color: _muted, fontSize: 12),
                        ),
                        if (plan.savings != null) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _green.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: _green.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              plan.savings!,
                              style: TextStyle(
                                color: _green,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? _gold : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? _gold : _muted,
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: isSelected
                          ? Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _bgDark,
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            if (plan.popular)
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _gold,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'MOST POPULAR',
                    style: TextStyle(
                      color: _bgDark,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            if (plan.badge != null && !plan.popular)
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    plan.badge!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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

class _SubscriptionButton extends StatelessWidget {
  const _SubscriptionButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_gold, _goldLight],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _gold.withValues(alpha: 0.3),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          'Start Subscription',
          style: TextStyle(
            color: _bgDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _TrustStatsWidget extends StatelessWidget {
  const _TrustStatsWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: _card.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _gold.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _TrustStatItem(value: '50K+', label: 'Protected'),
          Container(
            width: 1,
            height: 40,
            color: _gold.withValues(alpha: 0.2),
          ),
          _TrustStatItem(value: '99.9%', label: 'Success Rate'),
          Container(
            width: 1,
            height: 40,
            color: _gold.withValues(alpha: 0.2),
          ),
          _TrustStatItem(value: '24/7', label: 'Support'),
        ],
      ),
    );
  }
}

class _TrustStatItem extends StatelessWidget {
  const _TrustStatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: _gold,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: _muted, fontSize: 12),
        ),
      ],
    );
  }
}
