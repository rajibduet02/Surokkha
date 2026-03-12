import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';

/// OTP verification state: 6 digits, focus, validation, verifying, navigate.
class OtpController extends GetxController {
  final otp = <String>['', '', '', '', '', ''].obs;
  final focusNodes = List.generate(6, (_) => FocusNode());
  final textControllers = List.generate(6, (_) => TextEditingController());
  final isVerifying = false.obs;
  Timer? _verifyTimer;
  VoidCallback? onBeforeNavigate;

  /// Index of the OTP box that currently has focus (for Shortcuts backspace).
  int? _focusedIndex;
  int? get focusedIndex => _focusedIndex;

  void setOnBeforeNavigate(VoidCallback cb) {
    onBeforeNavigate = cb;
  }

  bool get isComplete => otp.every((d) => d.isNotEmpty);

  @override
  void onInit() {
    super.onInit();
    ever(otp, (_) => _onOtpChanged());
    for (var i = 0; i < focusNodes.length; i++) {
      final idx = i;
      focusNodes[i].addListener(() {
        if (focusNodes[idx].hasFocus) _focusedIndex = idx;
        update();
      });
    }
  }

  void _onOtpChanged() {
    if (!isComplete || isVerifying.value) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isVerifying.value && isComplete) {
        isVerifying.value = true;
        _verifyTimer = Timer(const Duration(milliseconds: 800), () {
          onBeforeNavigate?.call();
          if (Get.currentRoute != AppRoutes.profileType) {
            Get.offNamed(AppRoutes.profileType);
          }
        });
      }
    });
  }

  void setDigit(int index, String value) {
    if (value.length > 1) return;
    if (value.isNotEmpty && !RegExp(r'^\d$').hasMatch(value)) return;
    textControllers[index].text = value;
    textControllers[index].selection = TextSelection.collapsed(offset: value.length);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      otp[index] = value;
      if (value.isNotEmpty && index < 5) {
        focusNodes[index + 1].requestFocus();
      }
    });
  }

  void clearDigit(int index) {
    textControllers[index].clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      otp[index] = '';
    });
  }

  void onBackspace(int index) {
    if (otp[index].isNotEmpty) {
      clearDigit(index);
      return;
    }
    if (index > 0) {
      focusNodes[index - 1].requestFocus();
      clearDigit(index - 1);
    }
  }

  void onPaste(String pasted) {
    final digits = pasted.replaceAll(RegExp(r'\D'), '').split('').take(6).toList();
    if (digits.isEmpty) return;
    for (var i = 0; i < 6; i++) {
      final d = i < digits.length ? digits[i] : '';
      textControllers[i].text = d;
      textControllers[i].selection = TextSelection.collapsed(offset: d.length);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var i = 0; i < 6; i++) {
        otp[i] = i < digits.length ? digits[i] : '';
      }
      final lastIndex = digits.length < 6 ? digits.length : 5;
      focusNodes[lastIndex].requestFocus();
    });
  }

  void resendCode() {
    // TODO: call API to resend OTP
  }

  void goBack() {
    Get.back();
  }

  @override
  void onClose() {
    _verifyTimer?.cancel();
    for (final node in focusNodes) {
      node.dispose();
    }
    for (final c in textControllers) {
      c.dispose();
    }
    super.onClose();
  }
}
