import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

/// Splash screen matching React design: dark background, gold wave, shield + crown, gradient title.
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
  // Colors from React (exact match)
  static const Color _bg = Color(0xFF0A0A0F);
  static const Color _gold = Color(0xFFD4AF37);
  static const Color _goldLight = Color(0xFFF6D365);

  late AnimationController _waveController;
  late AnimationController _centerEnterController;
  late AnimationController _glowPulseController;
  late AnimationController _shieldRotateController;
  late AnimationController _crownController;
  late AnimationController _titleController;
  late AnimationController _taglineController;

  @override
  void initState() {
    super.initState();

    // Wave: 2s animate + 1s delay, repeat. X -100% -> 100%, opacity 0->1->1->0
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    // Center block: scale 0.8->1, opacity 0->1, 0.8s easeOut
    _centerEnterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    // Glow pulse: scale 1->1.2->1, opacity 0.3->0.5->0.3, 2s repeat
    _glowPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    // Shield: rotate 0->5->0->-5->0, 3s repeat
    _shieldRotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    // Crown: delay 0.4s, scale 0->1, rotate -180->0, 0.6s backOut
    _crownController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 400), () {}).then((_) {
      if (!mounted) return;
      _crownController.forward();
    });

    // Title: delay 0.6s, opacity 0->1, y 20->0, 0.6s
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 600), () {}).then((_) {
      if (!mounted) return;
      _titleController.forward();
    });

    // Tagline: delay 1s, opacity 0->1, 0.6s
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 1000), () {}).then((_) {
      if (!mounted) return;
      _taglineController.forward();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SplashController>().setOnBeforeNavigate(_stopRepeatingAnimations);
    });
  }

  void _stopRepeatingAnimations() {
    _waveController.stop();
    _glowPulseController.stop();
    _shieldRotateController.stop();
  }

  @override
  void dispose() {
    _waveController.stop();
    _waveController.dispose();
    _centerEnterController.stop();
    _centerEnterController.dispose();
    _glowPulseController.stop();
    _glowPulseController.dispose();
    _shieldRotateController.stop();
    _shieldRotateController.dispose();
    _crownController.stop();
    _crownController.dispose();
    _titleController.stop();
    _titleController.dispose();
    _taglineController.stop();
    _taglineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: RepaintBoundary(
        child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Corner glows — large radial glow, strong blur, very low opacity (match React)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 480,
              height: 480,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _gold.withValues(alpha: 0.04),
                boxShadow: [
                  BoxShadow(
                    color: _gold.withValues(alpha: 0.04),
                    blurRadius: 120,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 480,
              height: 480,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _goldLight.withValues(alpha: 0.04),
                boxShadow: [
                  BoxShadow(
                    color: _goldLight.withValues(alpha: 0.04),
                    blurRadius: 120,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),

          // Animated gold wave streak at top 1/3
          LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedBuilder(
                animation: _waveController,
                builder: (context, child) {
                  // Cycle: 2s animation + 1s delay (repeat). value 0->1 over 3s.
                  final t = _waveController.value;
                  final phase = t; // 0..1
                  final animProgress = phase < 2 / 3 ? (phase / (2 / 3)) : 1.0;
                  final x = -1.0 + 2.0 * animProgress;
                  double opacity;
                  if (phase >= 2 / 3) {
                    opacity = 0;
                  } else {
                    final p = animProgress;
                    opacity = p < 0.25
                        ? p / 0.25
                        : p < 0.75
                            ? 1.0
                            : (1 - p) / 0.25;
                  }
                  return Transform.translate(
                    offset: Offset(x * constraints.maxWidth, 0),
                    child: Opacity(
                      opacity: opacity.clamp(0.0, 1.0),
                      child: child,
                    ),
                  );
                },
                child: Align(
                  alignment: const Alignment(0, -0.33),
                  child: Container(
                    height: 2,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          _gold,
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _gold,
                          blurRadius: 30,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Center content
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _centerEnterController,
                _glowPulseController,
                _shieldRotateController,
                _crownController,
                _titleController,
                _taglineController,
              ]),
              builder: (context, _) {
                final enterCurve = Curves.easeOut;
                final scale = 0.8 +
                    (1 - 0.8) *
                        enterCurve.transform(_centerEnterController.value);
                final centerOpacity =
                    Curves.easeOut.transform(_centerEnterController.value);

                final glowScale = 1.0 + 0.2 * _glowPulseController.value;
                final glowOpacity =
                    0.3 + 0.2 * _glowPulseController.value;

                final shieldAngle =
                    (4 * _shieldRotateController.value - 2) * (5 * 3.14159 / 180);

                final crownScale = Curves.elasticOut
                    .transform(_crownController.value);
                final crownAngle =
                    (-180 + 180 * Curves.elasticOut.transform(_crownController.value)) *
                        3.14159 /
                        180;

                final titleOpacity =
                    Curves.easeOut.transform(_titleController.value);
                final titleOffset = 20 * (1 - Curves.easeOut.transform(_titleController.value));

                final taglineOpacity =
                    Curves.easeOut.transform(_taglineController.value);

                return Opacity(
                  opacity: centerOpacity,
                  child: Transform.scale(
                    scale: scale,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Glow background
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Transform.scale(
                              scale: glowScale,
                              child: Container(
                                width: 240,
                                height: 240,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _gold.withValues(alpha: glowOpacity),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _gold.withValues(alpha: glowOpacity),
                                      blurRadius: 120,
                                      spreadRadius: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Logo container: Shield (w-32 h-32 = 128) + Crown at top: -16, right: -16
                            Padding(
                              padding: const EdgeInsets.only(top: 16, right: 16),
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  Transform.rotate(
                                    angle: shieldAngle,
                                    child: Icon(
                                      Icons.shield_outlined,
                                      size: 128,
                                      color: _gold,
                                    ),
                                  ),
                                  Positioned(
                                    top: -16,
                                    right: -16,
                                    child: Transform.scale(
                                      scale: crownScale,
                                      child: Transform.rotate(
                                        angle: crownAngle,
                                        child: CustomPaint(
                                          size: const Size(48, 48),
                                          painter: _CrownPainter(color: _goldLight),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        // App name with gradient (D4AF37 → F6D365)
                        Transform.translate(
                          offset: Offset(0, titleOffset),
                          child: Opacity(
                            opacity: titleOpacity,
                            child: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  Color(0xFFD4AF37),
                                  Color(0xFFF6D365),
                                ],
                              ).createShader(bounds),
                              child: const Text(
                                'Surokkha',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Opacity(
                          opacity: taglineOpacity,
                          child: Text(
                            'Your Safety, Our Priority',
                            style: TextStyle(
                              color: const Color(0xFF8A8A92),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
        ),
      ),
    );
  }
}

/// Paints a simple crown shape (filled), matching Lucide-style crown.
class _CrownPainter extends CustomPainter {
  _CrownPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final p = Path()
      ..moveTo(w * 0.1, h * 0.55)
      ..lineTo(w * 0.1, h * 0.75)
      ..lineTo(w * 0.9, h * 0.75)
      ..lineTo(w * 0.9, h * 0.55)
      ..lineTo(w * 0.7, h * 0.4)
      ..lineTo(w * 0.5, h * 0.6)
      ..lineTo(w * 0.3, h * 0.4)
      ..close();
    canvas.drawPath(p, Paint()..color = color);

    // Three peaks
    final peak = Path()
      ..moveTo(w * 0.15, h * 0.55)
      ..lineTo(w * 0.5, h * 0.2)
      ..lineTo(w * 0.85, h * 0.55)
      ..lineTo(w * 0.7, h * 0.55)
      ..lineTo(w * 0.5, h * 0.35)
      ..lineTo(w * 0.3, h * 0.55)
      ..close();
    canvas.drawPath(peak, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
