import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/otp_controller.dart';

/// OTP verification screen — matches React/Figma layout, spacing, colors, behavior.
class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _OtpContent();
  }
}

class _OtpContent extends StatefulWidget {
  const _OtpContent();

  @override
  State<_OtpContent> createState() => _OtpContentState();
}

class _OtpContentState extends State<_OtpContent>
    with TickerProviderStateMixin {
  static const Color _bg = Color(0xFF0A0A0F);
  static const Color _gold = Color(0xFFD4AF37);
  static const Color _goldLight = Color(0xFFF6D365);
  static const Color _card = Color(0xFF1A1A22);
  static const Color _muted = Color(0xFF8A8A92);
  static const Color _success = Color(0xFF10B981);

  late AnimationController _otpSectionController;
  late AnimationController _logoGlowController;

  @override
  void initState() {
    super.initState();
    _otpSectionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(const Duration(milliseconds: 200), () {}).then((_) {
      if (!mounted) return;
      _otpSectionController.forward();
    });

    _logoGlowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<OtpController>().setOnBeforeNavigate(() {
        _logoGlowController.stop();
      });
      Future.delayed(const Duration(milliseconds: 150), () {
        if (!mounted) return;
        Get.find<OtpController>().focusNodes[0].requestFocus();
      });
    });
  }

  @override
  void dispose() {
    _otpSectionController.stop();
    _otpSectionController.dispose();
    _logoGlowController.stop();
    _logoGlowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OtpController>();
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      backgroundColor: _bg,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    32,
                    48,
                    32,
                    bottomInset + 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopSection(controller),
                      const SizedBox(height: 40),
                      _buildOtpSection(controller),
                      _buildBottomSection(controller),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopSection(OtpController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBackButton(controller),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: _buildLogoAndTitle(),
        ),
      ],
    );
  }

  Widget _buildBackButton(OtpController controller) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: controller.goBack,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _gold, width: 1),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.arrow_back_rounded, size: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildLogoAndTitle() {
    return AnimatedBuilder(
      animation: _logoGlowController,
      builder: (context, _) {
        final glowScale = 1.0 + 0.05 * _logoGlowController.value;
        final glowOpacity = 0.3 + 0.1 * _logoGlowController.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.scale(
                  scale: glowScale,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _gold.withValues(alpha: glowOpacity),
                      boxShadow: [
                        BoxShadow(
                          color: _gold.withValues(alpha: glowOpacity),
                          blurRadius: 40,
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.shield_outlined, size: 56, color: _gold),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Verify Code',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Enter the 6-digit code sent to',
              style: TextStyle(color: _muted, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              '+880 1712 345 678',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  Widget _buildOtpSection(OtpController controller) {
    return AnimatedBuilder(
      animation: _otpSectionController,
      builder: (context, _) {
        final opacity = Curves.easeOut.transform(_otpSectionController.value);
        return Opacity(
          opacity: opacity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: double.infinity, child: _buildOtpFields(controller)),
              const SizedBox(height: 28),
              _buildResendSection(),
              _buildVerifyingIndicator(controller),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOtpFields(OtpController controller) {
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.backspace): _BackspaceIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _BackspaceIntent: CallbackAction<_BackspaceIntent>(
            onInvoke: (_) {
              final idx = controller.focusedIndex ?? 0;
              controller.onBackspace(idx);
              return null;
            },
          ),
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mq = MediaQuery.sizeOf(context).width;
            final maxW = constraints.maxWidth.isFinite && constraints.maxWidth > 0
                ? constraints.maxWidth
                : (mq - 64).clamp(200.0, mq);

            const count = 6;
            const minGap = 4.0;
            const maxGap = 10.0;
            var gap = maxGap;
            var cellW = (maxW - (count - 1) * gap) / count;
            if (cellW > 48) {
              cellW = 48;
              gap = (maxW - count * cellW) / (count - 1);
              gap = gap.clamp(minGap, maxGap);
              cellW = (maxW - (count - 1) * gap) / count;
            } else if (cellW < 36) {
              gap = minGap;
              cellW = (maxW - (count - 1) * gap) / count;
            }

            return SizedBox(
              width: maxW,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  for (int index = 0; index < count; index++) ...[
                    if (index > 0) SizedBox(width: gap),
                    SizedBox(
                      width: cellW,
                      height: cellW,
                      child: TweenAnimationBuilder<double>(
                        key: ValueKey('otp_$index'),
                        tween: Tween(begin: 0, end: 1),
                        duration: Duration(milliseconds: 200 + index * 50),
                        builder: (context, value, child) {
                          return Opacity(opacity: value, child: child);
                        },
                        child: _OtpDigitBox(
                          index: index,
                          controller: controller,
                          size: cellW,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildResendSection() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Didn't receive the code?",
            style: TextStyle(color: _muted, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: Get.find<OtpController>().resendCode,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'Resend Code',
                  style: TextStyle(
                    color: _gold,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyingIndicator(OtpController controller) {
    return Obx(() {
      if (!controller.isComplete || !controller.isVerifying.value) {
        return const SizedBox.shrink();
      }
      return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(_success),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Verifying...',
                style: TextStyle(
                  color: _success,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBottomSection(OtpController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: SizedBox(
        width: double.infinity,
        child: _buildVerifyButton(controller),
      ),
    );
  }

  Widget _buildVerifyButton(OtpController controller) {
    return Obx(() {
      final isComplete = controller.isComplete;
      final isVerifying = controller.isVerifying.value;

      return _ScaleTap(
        onTap: isComplete && !isVerifying ? controller.submitVerification : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: isComplete
                ? const LinearGradient(
                    colors: [_gold, _goldLight],
                  )
                : null,
            color: isComplete ? null : const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(16),
            boxShadow: isComplete
                ? [
                    BoxShadow(
                      color: _gold.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            isVerifying ? 'Verifying...' : 'Verify Code',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isComplete ? const Color(0xFF0A0A0F) : Colors.white,
            ),
          ),
        ),
      );
    });
  }
}

class _OtpDigitBox extends StatefulWidget {
  const _OtpDigitBox({
    required this.index,
    required this.controller,
    this.size = 48,
  });

  final int index;
  final OtpController controller;
  final double size;

  @override
  State<_OtpDigitBox> createState() => _OtpDigitBoxState();
}

class _OtpDigitBoxState extends State<_OtpDigitBox> {
  static const Color _card = Color(0xFF1A1A22);
  static const Color _borderEmpty = Color(0xFF1A1A22);
  static const Color _gold = Color(0xFFD4AF37);

  final GlobalKey _boxKey = GlobalKey();

  FocusNode get _focusNode => widget.controller.focusNodes[widget.index];

  void _scrollIntoView() {
    final ctx = _boxKey.currentContext;
    if (ctx == null || !ctx.mounted) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
      alignment: 0.22,
      alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
    );
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_focusNode.hasFocus) return;
      _scrollIntoView();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !_focusNode.hasFocus) return;
        _scrollIntoView();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
      builder: (ctrl) {
        final digit = ctrl.otp[widget.index];
        final hasFocus = ctrl.focusNodes[widget.index].hasFocus;
        final isFilled = digit.isNotEmpty;
        final showGold = hasFocus || isFilled;

        final fontSize = (widget.size * 0.42).clamp(16.0, 20.0);
        final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

        return ClipRect(
          key: _boxKey,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: showGold ? _gold : _borderEmpty,
                width: showGold ? 2 : 1,
              ),
            ),
            alignment: Alignment.center,
            child: TextField(
              focusNode: ctrl.focusNodes[widget.index],
              controller: ctrl.textControllers[widget.index],
              scrollPadding: EdgeInsets.only(
                top: 120,
                bottom: bottomInset + 48,
              ),
              onChanged: (value) {
                if (value.length > 1) {
                  Future.microtask(() => ctrl.onPaste(value));
                  return;
                }
                if (value.isEmpty) {
                  ctrl.clearDigit(widget.index);
                  return;
                }
                ctrl.setDigit(widget.index, value);
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              textAlign: TextAlign.center,
              cursorColor: Colors.transparent,
              showCursor: false,
              enableInteractiveSelection: false,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Intent for Shortcuts to handle backspace in OTP fields.
class _BackspaceIntent extends Intent {
  const _BackspaceIntent();
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
