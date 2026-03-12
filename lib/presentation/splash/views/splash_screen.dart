import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

/// Splash screen: radial background, glow, logo (scale + fade), title, tagline.
class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SplashContent();
  }
}

class _SplashContent extends StatefulWidget {
  const _SplashContent();

  @override
  State<_SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<_SplashContent>
    with TickerProviderStateMixin {
  static const Color _gold = Color(0xFFD4AF37);

  late AnimationController _logoController;
  late AnimationController _glowController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _glowOpacityAnimation;
  late Animation<double> _glowBlurAnimation;
  late Animation<double> _glowSpreadAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _logoScaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOut,
      ),
    );
    _logoFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOut,
      ),
    );
    _logoController.forward();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _glowOpacityAnimation = Tween<double>(begin: 0.20, end: 0.45).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOut,
      ),
    );
    _glowBlurAnimation = Tween<double>(begin: 80, end: 140).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOut,
      ),
    );
    _glowSpreadAnimation = Tween<double>(begin: 10, end: 35).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOut,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Get.find<SplashController>().setOnBeforeNavigate(_stopGlow);
    });
  }

  void _stopGlow() {
    _glowController.stop();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.1,
            colors: [
              const Color(0xFF0A0B10),
              const Color(0xFF05060A),
              Colors.black,
            ],
          ),
        ),
        child: Stack(
          children: [
            // 1. Background (gradient is on Container above)
            // 2. Glow behind logo (opacity, blur, spread animated)
            Positioned.fill(
              child: Center(
                child: AnimatedBuilder(
                  animation: Listenable.merge([
                    _glowOpacityAnimation,
                    _glowBlurAnimation,
                    _glowSpreadAnimation,
                  ]),
                  builder: (context, child) {
                    return Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _gold.withOpacity(0.12),
                        boxShadow: [
                          BoxShadow(
                            color: _gold.withOpacity(_glowOpacityAnimation.value),
                            blurRadius: _glowBlurAnimation.value,
                            spreadRadius: _glowSpreadAnimation.value,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            // 3. Center content: logo (with Fade + Scale), title, tagline
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: _logoFadeAnimation,
                    child: ScaleTransition(
                      scale: _logoScaleAnimation,
                      child: _buildLogo(),
                    ),
                  ),
                  const SizedBox(height: 26),
                  const Text(
                    'Surokkha',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: _gold,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your Safety, Our Priority',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.shield_outlined,
          size: 110,
          color: _gold,
        ),
        Positioned(
          top: 12,
          right: 10,
          child: Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: _gold,
            ),
            child: const Icon(
              Icons.star,
              size: 14,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
