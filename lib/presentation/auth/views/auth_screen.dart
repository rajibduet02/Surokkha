import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../controllers/auth_controller.dart';

/// Login screen — matches React/Figma: phone input, Continue to OTP.
class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LoginContent();
  }
}

class _LoginContent extends StatefulWidget {
  const _LoginContent();

  @override
  State<_LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<_LoginContent>
    with TickerProviderStateMixin {
  late AnimationController _topController;
  late AnimationController _formController;
  late AnimationController _bottomController;
  late AnimationController _logoGlowController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _topController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _formController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 200), () {}).then((_) {
      if (!mounted) return;
      _formController.forward();
    });

    _bottomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 400), () {}).then((_) {
      if (!mounted) return;
      _bottomController.forward();
    });

    _logoGlowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().setOnBeforeNavigate(() {
        _logoGlowController.stop();
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _topController.stop();
    _topController.dispose();
    _formController.stop();
    _formController.dispose();
    _bottomController.stop();
    _bottomController.dispose();
    _logoGlowController.stop();
    _logoGlowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RepaintBoundary(
        child: SafeArea(
          child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  _buildTopSection(controller),
                  const Spacer(flex: 1),
                  _buildFormSection(controller),
                  const Spacer(flex: 1),
                  _buildBottomSection(controller),
                ],
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildTopSection(AuthController controller) {
    return AnimatedBuilder(
      animation: _topController,
      builder: (context, _) {
        final opacity = Curves.easeOut.transform(_topController.value);
        final dy = -20 * (1 - Curves.easeOut.transform(_topController.value));
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, dy),
            child: Column(
              children: [
                _buildLogo(controller),
                const SizedBox(height: 16),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.foreground,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue protection',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo(AuthController controller) {
    return AnimatedBuilder(
      animation: _logoGlowController,
      builder: (context, _) {
        final glowScale = 1.0 + 0.05 * _logoGlowController.value;
        final glowOpacity = 0.3 + 0.1 * _logoGlowController.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: glowScale,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.goldPrimary.withValues(alpha: glowOpacity),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goldPrimary
                          .withValues(alpha: glowOpacity),
                      blurRadius: 40,
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.shield_outlined,
              size: 64,
              color: AppColors.goldPrimary,
            ),
          ],
        );
      },
    );
  }

  Widget _buildFormSection(AuthController controller) {
    return AnimatedBuilder(
      animation: _formController,
      builder: (context, _) {
        final opacity = Curves.easeOut.transform(_formController.value);
        final dy = 20 * (1 - Curves.easeOut.transform(_formController.value));
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, dy),
            child: Obx(() => _buildPhoneField(controller)),
          ),
        );
      },
    );
  }

  Widget _buildPhoneField(AuthController controller) {
    final isFocused = controller.isFocused.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Phone Number',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: isFocused ? AppColors.goldPrimary : AppColors.secondary,
              width: 2,
            ),
            boxShadow: isFocused
                ? [
                    BoxShadow(
                      color: AppColors.goldPrimary.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Country code selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🇧🇩', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 6),
                    Text(
                      '+880',
                      style: TextStyle(
                        color: AppColors.foreground,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 14,
                      color: AppColors.mutedForeground,
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 24,
                color: AppColors.secondary,
              ),
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  onChanged: controller.setPhoneNumber,
                  onTap: () => controller.setFocused(true),
                  onTapOutside: (_) => controller.setFocused(false),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  style: TextStyle(
                    color: AppColors.foreground,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: '1712 345 678',
                    hintStyle: TextStyle(
                      color: AppColors.mutedForeground,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, top: 8),
          child: Text(
            "We'll send you a verification code",
            style: TextStyle(
              fontSize: 12,
              color: AppColors.mutedForeground,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection(AuthController controller) {
    return AnimatedBuilder(
      animation: _bottomController,
      builder: (context, _) {
        final opacity = Curves.easeOut.transform(_bottomController.value);
        final dy = 20 * (1 - Curves.easeOut.transform(_bottomController.value));
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, dy),
            child: Column(
              children: [
                Obx(() => _buildContinueButton(controller)),
                const SizedBox(height: 24),
                _buildTermsText(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContinueButton(AuthController controller) {
    final canContinue = controller.canContinue;

    return _ScaleTap(
      onTap: canContinue ? controller.navigateToOtp : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: canContinue
              ? const LinearGradient(
                  colors: [
                    AppColors.goldPrimary,
                    AppColors.goldSecondary,
                  ],
                )
              : null,
          color: canContinue ? null : AppColors.secondary,
          borderRadius: BorderRadius.circular(AppRadius.md),
          boxShadow: canContinue
              ? [
                  BoxShadow(
                    color: AppColors.goldPrimary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          'Continue',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: canContinue
                ? AppColors.primaryForeground
                : AppColors.mutedForeground,
          ),
        ),
      ),
    );
  }

  Widget _buildTermsText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 12,
            color: AppColors.mutedForeground,
          ),
          children: [
            const TextSpan(text: 'By continuing, you agree to our '),
            TextSpan(
              text: 'Terms of Service',
              style: TextStyle(color: AppColors.goldPrimary),
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(color: AppColors.goldPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScaleTap extends StatefulWidget {
  const _ScaleTap({required this.onTap, required this.child});

  final VoidCallback? onTap;
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
      onTapDown: widget.onTap != null ? (_) => _controller.forward() : null,
      onTapUp: widget.onTap != null ? (_) => _controller.reverse() : null,
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
