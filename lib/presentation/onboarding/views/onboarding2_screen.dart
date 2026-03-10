import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';

/// Onboarding 2: Live Guardian Tracking — matches React/Figma layout and animations.
class Onboarding2Screen extends StatefulWidget {
  const Onboarding2Screen({super.key});

  @override
  State<Onboarding2Screen> createState() => _Onboarding2ScreenState();
}

class _Onboarding2ScreenState extends State<Onboarding2Screen>
    with TickerProviderStateMixin {
  static const Color _bg = Color(0xFF0A0A0F);
  static const Color _gold = Color(0xFFD4AF37);
  static const Color _goldLight = Color(0xFFF6D365);
  static const Color _gray = Color(0xFF8A8A92);
  static const Color _grayLight = Color(0xFFCFCFCF);
  static const Color _cardDark = Color(0xFF1A1A22);
  static const Color _cardDark2 = Color(0xFF2A2A32);
  static const Color _indicatorInactive = Color(0xFF2A2A32);

  late AnimationController _contentController;
  late AnimationController _iconBlockController;
  late AnimationController _glowPulseController;
  late AnimationController _mapPinPulseController;
  late AnimationController _badgeController;
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

    // MapPin ripple: scale [1, 1.3, 1], opacity [0.5, 0, 0.5], 2s repeat
    _mapPinPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _badgeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 400), () {}).then((_) {
      if (!mounted) return;
      _badgeController.forward();
    });

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
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 800), () {}).then((_) {
      if (!mounted) return;
      _bottomController.forward();
    });
  }

  void _stopRepeatingAnimations() {
    _glowPulseController.stop();
    _mapPinPulseController.stop();
  }

  @override
  void dispose() {
    _contentController.stop();
    _contentController.dispose();
    _iconBlockController.stop();
    _iconBlockController.dispose();
    _glowPulseController.stop();
    _glowPulseController.dispose();
    _mapPinPulseController.stop();
    _mapPinPulseController.dispose();
    _badgeController.stop();
    _badgeController.dispose();
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
                                _buildContinueButton(),
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
        _mapPinPulseController,
        _badgeController,
      ]),
      builder: (context, _) {
        final scale = 0.8 +
            0.2 * Curves.easeOut.transform(_iconBlockController.value);
        final opacity = Curves.easeOut.transform(_iconBlockController.value);
        final glowScale = 1.0 + 0.1 * _glowPulseController.value;
        final glowOpacity = 0.2 + 0.1 * _glowPulseController.value;
        final badgeScale = Curves.elasticOut.transform(_badgeController.value);

        final t = _mapPinPulseController.value;
        final mapPinScale = t < 0.5 ? 1.0 + 0.3 * (t * 2) : 1.3 - 0.3 * ((t - 0.5) * 2);
        final mapPinOpacity = t < 0.5 ? 0.5 - (t * 2) * 0.5 : (t - 0.5) * 2 * 0.5;

        return Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Glow — F6D365 (light gold), blur 60
                Transform.scale(
                  scale: glowScale,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _goldLight.withValues(alpha: glowOpacity),
                      boxShadow: [
                        BoxShadow(
                          color: _goldLight.withValues(alpha: glowOpacity),
                          blurRadius: 60,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
                // Circle with gradient + border F6D365/20
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
                      color: _goldLight.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 64,
                        color: _goldLight,
                      ),
                      // Pulsing overlay MapPin
                      Transform.scale(
                        scale: mapPinScale,
                        child: Opacity(
                          opacity: mapPinOpacity.clamp(0.0, 1.0),
                          child: Icon(
                            Icons.location_on_outlined,
                            size: 64,
                            color: _goldLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Badge: bottom-right, gradient circle, border 4px bg, Users icon
                Positioned(
                  bottom: -8,
                  right: -8,
                  child: Transform.scale(
                    scale: badgeScale,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [_gold, _goldLight],
                        ),
                        border: Border.all(color: _bg, width: 4),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.people_outline,
                        size: 24,
                        color: _bg,
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
                'Live Guardian\nTracking',
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
              "Share your real-time location with trusted contacts. They'll always know you're safe on your journey.",
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
            gradient: const LinearGradient(
              colors: [_gold, _goldLight],
            ),
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
      ],
    );
  }

  Widget _buildContinueButton() {
    return _ScaleTap(
      onTap: () {
        _stopRepeatingAnimations();
        if (Get.currentRoute != AppRoutes.onboarding3) {
          Get.offNamed(AppRoutes.onboarding3);
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
          'Continue',
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
