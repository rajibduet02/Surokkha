import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';

// Design tokens (match React/Figma)
const Color _bgDark = Color(0xFF0A0A0F);
const Color _card = Color(0xFF1A1A22);
const Color _gold = Color(0xFFD4AF37);
const Color _goldLight = Color(0xFFF6D365);
const Color _muted = Color(0xFF8A8A92);
const Color _textSoft = Color(0xFFCFCFCF);
const Color _buttonDisabled = Color(0xFF2A2A32);

/// Profile type selection. Matches React ProfileTypeScreen and reference images.
class ProfileTypeScreen extends StatefulWidget {
  const ProfileTypeScreen({super.key});

  @override
  State<ProfileTypeScreen> createState() => _ProfileTypeScreenState();
}

class _ProfileTypeScreenState extends State<ProfileTypeScreen> {
  String? selectedType;

  void _onContinue() {
    if (selectedType == null) return;
    // TODO: Set user profile in app context/controller/store when available.
    // type: selectedType, name: selectedType == "child" ? "Child User" : "Woman User"
    if (Get.currentRoute == AppRoutes.profileType) {
      Get.toNamed(AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildAmbientGlow(),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 32),
                        _buildProfileCards(),
                        const SizedBox(height: 32),
                        _ContinueButton(
                          enabled: selectedType != null,
                          onPressed: _onContinue,
                        ),
                        const SizedBox(height: 24),
                        _buildProgressText(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_bgDark, _bgDark, _card],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildAmbientGlow() {
    return Positioned(
      top: -120,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 384,
          height: 384,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _gold.withValues(alpha: 0.1),
                blurRadius: 80,
                spreadRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: const LinearGradient(
              colors: [_gold, _goldLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.shield_outlined, size: 40, color: _bgDark),
        ),
        const SizedBox(height: 24),
        Text(
          'Choose Your Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Select your profile type to personalize your safety experience',
            style: TextStyle(color: _textSoft, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCards() {
    return Column(
      children: [
        _ProfileOptionCard(
          type: 'woman',
          title: 'Woman',
          description: 'Full safety features for adult women',
          icon: Icons.person_outline,
          features: const [
            'Emergency contacts & guardians',
            'Workplace & safe zone alerts',
            'Real-time location sharing',
          ],
          isSelected: selectedType == 'woman',
          onTap: () => setState(() => selectedType = 'woman'),
        ),
        const SizedBox(height: 16),
        _ProfileOptionCard(
          type: 'child',
          title: 'Child',
          description: 'Simplified safety for children under 18',
          icon: Icons.child_care_outlined,
          features: const [
            'Parent & trusted adult contacts',
            'School & home safe zones',
            'Simple one-tap emergency',
          ],
          isSelected: selectedType == 'child',
          onTap: () => setState(() => selectedType = 'child'),
        ),
      ],
    );
  }

  Widget _buildProgressText() {
    return Text(
      'Step 3 of 3 • Setup your profile',
      style: TextStyle(color: _muted, fontSize: 12),
      textAlign: TextAlign.center,
    );
  }
}

class _ProfileOptionCard extends StatelessWidget {
  const _ProfileOptionCard({
    required this.type,
    required this.title,
    required this.description,
    required this.icon,
    required this.features,
    required this.isSelected,
    required this.onTap,
  });

  final String type;
  final String title;
  final String description;
  final IconData icon;
  final List<String> features;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? _gold : _gold.withValues(alpha: 0.2),
              width: 2,
            ),
            color: isSelected ? null : _card.withValues(alpha: 0.6),
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      _gold.withValues(alpha: 0.2),
                      _goldLight.withValues(alpha: 0.2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isSelected ? null : _gold.withValues(alpha: 0.2),
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [_gold, _goldLight],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      icon,
                      size: 32,
                      color: isSelected ? _bgDark : _gold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(color: _textSoft, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: _gold,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.check, size: 16, color: _bgDark),
                    ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isSelected ? 1 : 0,
                  child: isSelected
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Container(
                              height: 1,
                              color: _gold.withValues(alpha: 0.2),
                            ),
                            const SizedBox(height: 16),
                            ...features.map(
                              (f) => _FeatureItem(text: f),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _gold,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _gold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({
    required this.enabled,
    required this.onPressed,
  });

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: enabled ? null : _buttonDisabled,
            gradient: enabled
                ? const LinearGradient(
                    colors: [_gold, _goldLight],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: enabled ? _bgDark : _muted,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: 20,
                color: enabled ? _bgDark : _muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
