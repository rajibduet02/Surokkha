import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';

/// Onboarding 1: Instant SOS Protection — matches React layout and animations.
class Onboarding1Screen extends StatefulWidget {
  const Onboarding1Screen({super.key});

  @override
  State<Onboarding1Screen> createState() => _Onboarding1ScreenState();
}

class _Onboarding1ScreenState extends State<Onboarding1Screen>
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
  late AnimationController _headlineController;
  late AnimationController _subtextController;
  late AnimationController _bottomController;

  @override
  void initState() {
    super.initState();

    // Content block: opacity 0->1, y 40->0, 0.8s
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    // Icon block: scale 0.8->1, opacity 0->1, delay 0.2s, 0.6s
    _iconBlockController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 200), () {}).then((_) {
      if (!mounted) return;
      _iconBlockController.forward();
    });

    // Glow behind icon: scale [1, 1.1, 1], opacity [0.2, 0.3, 0.2], 3s repeat
    _glowPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    // Headline: opacity 0->1, y 20->0, delay 0.4s, 0.6s
    _headlineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 400), () {}).then((_) {
      if (!mounted) return;
      _headlineController.forward();
    });

    // Subtext: opacity 0->1, delay 0.6s, 0.6s
    _subtextController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 600), () {}).then((_) {
      if (!mounted) return;
      _subtextController.forward();
    });

    // Bottom: opacity 0->1, y 20->0, delay 0.8s, 0.6s
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
  }

  @override
  void dispose() {
    _contentController.stop();
    _contentController.dispose();
    _iconBlockController.stop();
    _iconBlockController.dispose();
    _glowPulseController.stop();
    _glowPulseController.dispose();
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 48,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      // Top spacer
                      const Spacer(flex: 1),

                      // Content
                      AnimatedBuilder(
                        animation: _contentController,
                        builder: (context, _) {
                          final opacity = Curves.easeOut.transform(
                            _contentController.value,
                          );
                          final dy =
                              40 *
                              (1 -
                                  Curves.easeOut.transform(
                                    _contentController.value,
                                  ));
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

                      // Bottom section
                      AnimatedBuilder(
                        animation: _bottomController,
                        builder: (context, _) {
                          final opacity = Curves.easeOut.transform(
                            _bottomController.value,
                          );
                          final dy =
                              20 *
                              (1 -
                                  Curves.easeOut.transform(
                                    _bottomController.value,
                                  ));
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
      animation: Listenable.merge([_iconBlockController, _glowPulseController]),
      builder: (context, _) {
        final scale =
            0.8 + 0.2 * Curves.easeOut.transform(_iconBlockController.value);
        final opacity = Curves.easeOut.transform(_iconBlockController.value);
        final glowScale = 1.0 + 0.1 * _glowPulseController.value;
        final glowOpacity = 0.2 + 0.1 * _glowPulseController.value;

        return Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Pulsing glow
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
                // Circle with gradient + border
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
                  // child: Icon(
                  //   Icons.shield_outlined,
                  //   size: 80,
                  //   color: _gold,
                  // ),
                  child: SvgPicture.asset(
                    'assets/icons/shield-alert.svg',
                    width: 80,
                    height: 80,
                    color: _gold,
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
        final opacity = Curves.easeOut.transform(_headlineController.value);
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
                'Instant SOS\nProtection',
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
        final opacity = Curves.easeOut.transform(_subtextController.value);
        return Opacity(
          opacity: opacity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'One tap to alert your trusted contacts and authorities. Help arrives within seconds when you need it most.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _grayLight, fontSize: 16, height: 1.5),
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
            gradient: const LinearGradient(colors: [_gold, _goldLight]),
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
        if (Get.currentRoute != AppRoutes.onboarding2) {
          Get.offNamed(AppRoutes.onboarding2);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [_gold, _goldLight]),
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
              style: TextStyle(color: _gray, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}

/// Wraps child with scale-on-tap/hover effect (matches React whileTap / whileHover).
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
    _scale = Tween<double>(
      begin: 1,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
        builder: (context, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: widget.child,
      ),
    );
  }
}
