import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

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

  // Controllers
  late AnimationController _logoController;
  late AnimationController _glowController;
  late AnimationController _rotateController;
  late AnimationController _waveController;
  late AnimationController _crownController;

  // Animations
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;

  late Animation<double> _glowOpacityAnimation;
  late Animation<double> _glowBlurAnimation;
  late Animation<double> _glowSpreadAnimation;

  late Animation<double> _rotationAnimation;
  late Animation<double> _waveAnimation;

  late Animation<double> _crownScale;
  late Animation<double> _crownRotate;

  @override
  void initState() {
    super.initState();

    // Logo scale + fade
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOutBack,
      ),
    );

    _logoFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );

    _logoController.forward();

    // Glow animation
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _glowOpacityAnimation = Tween<double>(begin: 0.15, end: 0.4).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _glowBlurAnimation = Tween<double>(begin: 80, end: 140).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _glowSpreadAnimation = Tween<double>(begin: 10, end: 35).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    // Shield rotate
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _rotationAnimation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.easeInOut),
    );

    // Wave
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _waveAnimation = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );

    // Crown (ONE TIME)
    _crownController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _crownScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _crownController, curve: Curves.easeOutBack),
    );

    _crownRotate = Tween<double>(begin: -3.14, end: 0).animate(
      CurvedAnimation(parent: _crownController, curve: Curves.easeOut),
    );

    Future.delayed(const Duration(milliseconds: 400), () {
      _crownController.forward();
    });

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
    _rotateController.dispose();
    _waveController.dispose();
    _crownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.1,
            colors: [
              Color(0xFF0A0B10),
              Color(0xFF05060A),
              Colors.black,
            ],
          ),
        ),
        child: Stack(
          children: [
            // 🌊 Wave
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _waveAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      _waveAnimation.value *
                          MediaQuery.of(context).size.width,
                      -80,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 4,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Color(0xFFD4AF37),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ✨ Glow
            Center(
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
                      color: _gold.withOpacity(0.08),
                      boxShadow: [
                        BoxShadow(
                          color: _gold.withOpacity(
                              _glowOpacityAnimation.value),
                          blurRadius: _glowBlurAnimation.value,
                          spreadRadius: _glowSpreadAnimation.value,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Center Content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: _logoFadeAnimation,
                    child: _buildLogo(),
                  ),
                  const SizedBox(height: 26),
                  const Text(
                    'Surokkha',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: _gold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your Safety, Our Priority',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
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
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // 🛡️ Shield (scale + rotate together)
        AnimatedBuilder(
          animation: Listenable.merge([
            _rotationAnimation,
            _logoScaleAnimation,
          ]),
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child: Transform.scale(
                scale: _logoScaleAnimation.value,
                child: child,
              ),
            );
          },
          child: SvgPicture.asset(
            'assets/icons/shield-alert.svg',
            width: 110,
            height: 110,
            color: const Color(0xFFD4AF37),
          ),
        ),

        // 👑 Crown (one-time)
        Positioned(
          top: -10,
          right: -10,
          child: AnimatedBuilder(
            animation: _crownController,
            builder: (context, child) {
              return Transform.scale(
                scale: _crownScale.value,
                child: Transform.rotate(
                  angle: _crownRotate.value,
                  child: child,
                ),
              );
            },
            child: SvgPicture.asset(
              'assets/icons/crown.svg',
              width: 40,
              height: 40,
              color: const Color(0xFFF6D365),
            ),
          ),
        ),
      ],
    );
  }
}