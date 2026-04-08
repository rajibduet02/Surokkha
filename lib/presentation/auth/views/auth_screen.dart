import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
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
  static const double _inputRadius = 20;
  static const double _buttonRadius = 20;

  late AnimationController _topController;
  late AnimationController _formController;
  late AnimationController _bottomController;
  late AnimationController _logoGlowController;
  late TextEditingController _phoneController;
  late FocusNode _phoneFocusNode;

  void _onPhoneFocusChanged() {
    if (!mounted) return;
    if (!Get.isRegistered<AuthController>()) return;
    Get.find<AuthController>().setFocused(_phoneFocusNode.hasFocus);
  }

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _phoneFocusNode = FocusNode()..addListener(_onPhoneFocusChanged);

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
      if (!mounted) return;
      if (!Get.isRegistered<AuthController>()) return;
      Get.find<AuthController>().setOnBeforeNavigate(() {
        _logoGlowController.stop();
      });
    });
  }

  @override
  void dispose() {
    _phoneFocusNode.removeListener(_onPhoneFocusChanged);
    _phoneFocusNode.dispose();
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
    if (!Get.isRegistered<AuthController>()) {
      return const Scaffold(body: SizedBox.shrink());
    }
    final controller = Get.find<AuthController>();
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final isSmall = MediaQuery.sizeOf(context).height < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: RepaintBoundary(
        child: SafeArea(
          child: CustomScrollView(
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(bottom: bottomInset),
                sliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 430),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 48,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: isSmall ? 12 : 24),
                            _buildTopSection(controller, isSmall),
                            const Spacer(),
                            _buildFormSection(controller),
                            const Spacer(),
                            _buildBottomSection(controller, isSmall),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection(AuthController controller, bool isSmall) {
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLogo(controller),
                const SizedBox(height: 16),
                Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.foreground,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue protection',
                  textAlign: TextAlign.center,
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
        final glowOpacity = 0.30 + 0.10 * _logoGlowController.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: glowScale,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.goldPrimary.withValues(alpha: glowOpacity),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goldPrimary.withValues(
                        alpha: glowOpacity * 0.85,
                      ),
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(_inputRadius),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'BD',
                      style: TextStyle(
                        color: AppColors.foreground,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
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
                      size: 16,
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
                  focusNode: _phoneFocusNode,
                  onChanged: (v) {
                    controller.setPhoneNumber(v);
                  },
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    _BangladeshPhoneDisplayFormatter(),
                    LengthLimitingTextInputFormatter(13),
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
                    filled: false,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    isDense: true,
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

  Widget _buildBottomSection(AuthController controller, bool isSmall) {
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(() => _buildContinueButton(controller)),
                SizedBox(height: isSmall ? 16 : 24),
                _buildTermsText(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContinueButton(AuthController controller) {
    final canContinue = controller.canContinue;
    final loading = controller.isSigningIn.value;
    final tapEnabled = canContinue && !loading;
    final showPrimaryStyle = canContinue;

    return _ScaleTap(
      onTap: tapEnabled ? () => controller.signInAndContinue() : null,
      child: SizedBox(
        width: double.infinity,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          width: double.infinity,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: showPrimaryStyle
                ? const LinearGradient(
                    colors: [
                      AppColors.goldPrimary,
                      AppColors.goldSecondary,
                    ],
                  )
                : null,
            color: showPrimaryStyle ? null : AppColors.secondary,
            borderRadius: BorderRadius.circular(_buttonRadius),
            boxShadow: showPrimaryStyle
                ? [
                    BoxShadow(
                      color: AppColors.goldPrimary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: loading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: showPrimaryStyle
                        ? AppColors.primaryForeground
                        : AppColors.mutedForeground,
                  ),
                )
              : Text(
                  'Continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: showPrimaryStyle
                        ? AppColors.primaryForeground
                        : AppColors.mutedForeground,
                  ),
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

/// Formats up to 11 digits as `1712 345 678`; controller stores digits only via [AuthController.setPhoneNumber].
class _BangladeshPhoneDisplayFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final truncated =
        digits.length > 11 ? digits.substring(0, 11) : digits;

    final buf = StringBuffer();
    for (var i = 0; i < truncated.length; i++) {
      if (i == 4 || i == 7) buf.write(' ');
      buf.write(truncated[i]);
    }
    final text = buf.toString();

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
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
    _scale = Tween<double>(begin: 1, end: 0.95).animate(
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
