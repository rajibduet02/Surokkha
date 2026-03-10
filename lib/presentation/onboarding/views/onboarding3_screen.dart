import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';

/// Onboarding 3: Bangladesh Emergency 999 — matches React/Figma layout and animations.
class Onboarding3Screen extends StatefulWidget {
  const Onboarding3Screen({super.key});

  @override
  State<Onboarding3Screen> createState() => _Onboarding3ScreenState();
}

class _Onboarding3ScreenState extends State<Onboarding3Screen>
    with TickerProviderStateMixin {
  static const Color _bg = Color(0xFF0A0A0F);
  static const Color _gold = Color(0xFFD4AF37);
  static const Color _goldLight = Color(0xFFF6D365);
  static const Color _gray = Color(0xFF8A8A92);
  static const Color _grayLight = Color(0xFFCFCFCF);
  static const Color _cardDark = Color(0xFF1A1A22);
  static const Color _cardDark2 = Color(0xFF2A2A32);
  static const Color _indicatorInactive = Color(0xFF2A2A32);
  static const Color _redPrimary = Color(0xFFEF4444);
  static const Color _redDark = Color(0xFFDC2626);

  late AnimationController _contentController;
  late AnimationController _iconBlockController;
  late AnimationController _glowPulseController;
  late AnimationController _phoneRotateController;
  late AnimationController _badgeController;
  late AnimationController _sirenRotateController;
  late AnimationController _headlineController;
  late AnimationController _subtextController;
  late AnimationController _bottomController;

  @override
  void initState() {
    super.initState();

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _iconBlockController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 200), () {}).then((_) {
      if (!mounted) return;
      _iconBlockController.forward();
    });

    _glowPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    // Phone: rotate [0, 10, 0, -10, 0] deg, 2s repeat
    _phoneRotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _badgeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 400), () {}).then((_) {
      if (!mounted) return;
      _badgeController.forward();
    });

    // Siren: rotate 360, 2s repeat, linear
    _sirenRotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _headlineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 400), () {}).then((_) {
      if (!mounted) return;
      _headlineController.forward();
    });

    _subtextController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 600), () {}).then((_) {
      if (!mounted) return;
      _subtextController.forward();
    });

    _bottomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    Future.delayed(const Duration(milliseconds: 800), () {}).then((_) {
      if (!mounted) return;
      _bottomController.forward();
    });
  }

  void _stopRepeatingAnimations() {
    _glowPulseController.stop();
    _phoneRotateController.stop();
    _sirenRotateController.stop();
  }

  @override
  void dispose() {
    _contentController.stop();
    _contentController.dispose();
    _iconBlockController.stop();
    _iconBlockController.dispose();
    _glowPulseController.stop();
    _glowPulseController.dispose();
    _phoneRotateController.stop();
    _phoneRotateController.dispose();
    _badgeController.stop();
    _badgeController.dispose();
    _sirenRotateController.stop();
    _sirenRotateController.dispose();
    _headlineController.stop();
    _headlineController.dispose();
    _subtextController.stop();
    _subtextController.dispose();
    _bottomController.stop();
    _bottomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: RepaintBoundary(
        child: SafeArea(
          child: SizedBox.expand(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    const Spacer(flex: 1),
                    AnimatedBuilder(
                      animation: _contentController,
                      builder: (context, _) {
                        final opacity =
                            Curves.easeOut.transform(_contentController.value);
                        final dy = 40 *
                            (1 - Curves.easeOut.transform(_contentController.value));
                        return Opacity(
                          opacity: opacity,
                          child: Transform.translate(
                            offset: Offset(0, dy),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildIconSection(),
                                const SizedBox(height: 32),
                                _buildHeadline(),
                                const SizedBox(height: 32),
                                _buildSubtext(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const Spacer(flex: 1),
                    AnimatedBuilder(
                      animation: _bottomController,
                      builder: (context, _) {
                        final opacity =
                            Curves.easeOut.transform(_bottomController.value);
                        final dy = 20 *
                            (1 -
                                Curves.easeOut.transform(_bottomController.value));
                        return Opacity(
                          opacity: opacity,
                          child: Transform.translate(
                            offset: Offset(0, dy),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildIndicators(),
                                const SizedBox(height: 24),
                                _buildGetStartedButton(),
                                const SizedBox(height: 8),
                                _buildSkipButton(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildIconSection() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _iconBlockController,
        _glowPulseController,
        _phoneRotateController,
        _badgeController,
        _sirenRotateController,
      ]),
      builder: (context, _) {
        final scale = 0.8 +
            0.2 * Curves.easeOut.transform(_iconBlockController.value);
        final opacity = Curves.easeOut.transform(_iconBlockController.value);
        final glowScale = 1.0 + 0.1 * _glowPulseController.value;
        final glowOpacity = 0.2 + 0.1 * _glowPulseController.value;
        final badgeScale = Curves.elasticOut.transform(_badgeController.value);
        final phoneAngle = (10 * math.pi / 180) *
            math.sin(_phoneRotateController.value * 2 * math.pi);
        final sirenAngle = _sirenRotateController.value * 2 * math.pi;

        return Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Glow — D4AF37 (gold), blur 60
                Transform.scale(
                  scale: glowScale,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _gold.withValues(alpha: glowOpacity),
                      boxShadow: [
                        BoxShadow(
                          color: _gold.withValues(alpha: glowOpacity),
                          blurRadius: 60,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
                // Circle with gradient + border D4AF37/20
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [_cardDark, _cardDark2],
                    ),
                    border: Border.all(
                      color: _gold.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: phoneAngle,
                    child: Icon(
                      Icons.phone_outlined,
                      size: 80,
                      color: _gold,
                    ),
                  ),
                ),
                // Badge: top-right, 56x56, red gradient, border 4px bg, Siren spinning
                Positioned(
                  top: -8,
                  right: -8,
                  child: Transform.scale(
                    scale: badgeScale,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [_redPrimary, _redDark],
                        ),
                        border: Border.all(color: _bg, width: 4),
                      ),
                      alignment: Alignment.center,
                      child: Transform.rotate(
                        angle: sirenAngle,
                        child: Icon(
                          Icons.emergency,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeadline() {
    return AnimatedBuilder(
      animation: _headlineController,
      builder: (context, _) {
        final opacity =
            Curves.easeOut.transform(_headlineController.value);
        final dy =
            20 * (1 - Curves.easeOut.transform(_headlineController.value));
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, dy),
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(
                colors: [_gold, _goldLight],
              ).createShader(bounds),
              child: const Text(
                'Bangladesh\nEmergency 999',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubtext() {
    return AnimatedBuilder(
      animation: _subtextController,
      builder: (context, _) {
        final opacity =
            Curves.easeOut.transform(_subtextController.value);
        return Opacity(
          opacity: opacity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Direct hotline integration with Bangladesh Police. Instant connection to authorities in critical situations.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _grayLight,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 32,
          height: 4,
          decoration: BoxDecoration(
            color: _indicatorInactive,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 32,
          height: 4,
          decoration: BoxDecoration(
            color: _indicatorInactive,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 32,
          height: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_gold, _goldLight],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildGetStartedButton() {
    return _ScaleTap(
      onTap: () {
        _stopRepeatingAnimations();
        if (Get.currentRoute != AppRoutes.auth) {
          Get.offNamed(AppRoutes.auth);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_gold, _goldLight],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _gold.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          'Get Started',
          style: TextStyle(
            color: _bg,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _stopRepeatingAnimations();
          if (Get.currentRoute != AppRoutes.auth) {
            Get.offNamed(AppRoutes.auth);
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: const SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Skip',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _gray,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class _ScaleTap extends StatefulWidget {
  const _ScaleTap({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  State<_ScaleTap> createState() => _ScaleTapState();
}

class _ScaleTapState extends State<_ScaleTap>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) => Transform.scale(
          scale: _scale.value,
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}
