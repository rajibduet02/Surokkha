import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/auth_storage_service.dart';

/// OTP verification: calls `/verify-otp`, saves token, routes by `needs_account_type`.
class OtpController extends GetxController {
  final otp = <String>['', '', '', '', '', ''].obs;
  final focusNodes = List.generate(6, (_) => FocusNode());
  final textControllers = List.generate(6, (_) => TextEditingController());
  final isVerifying = false.obs;
  VoidCallback? onBeforeNavigate;

  String? _phoneNo;

  late final ApiService _api;
  late final AuthStorageService _authStorage;

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
    _api = Get.find<ApiService>();
    _authStorage = Get.find<AuthStorageService>();

    final args = Get.arguments;
    if (args is Map) {
      final p = args['phone_no'];
      if (p is String && p.isNotEmpty) _phoneNo = p;
    }

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
      if (!isComplete || isVerifying.value) return;
      submitVerification();
    });
  }

  void _clearOtpAndFocus() {
    for (var i = 0; i < 6; i++) {
      textControllers[i].clear();
      otp[i] = '';
    }
    update();
    focusNodes[0].requestFocus();
  }

  /// Manual Verify button and auto-submit when 6 digits are entered.
  Future<void> submitVerification() async {
    if (!isComplete || isVerifying.value) return;

    final phone = _phoneNo;
    if (phone == null || phone.isEmpty) {
      Get.snackbar(
        'Verification',
        'Phone number missing. Go back and sign in again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    isVerifying.value = true;
    final code = otp.join();

    try {
      final result = await _api.verifyOtp(phone, code);
      if (!result.success) {
        isVerifying.value = false;
        Get.snackbar(
          'Verification',
          result.message ?? 'Could not verify code',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
        _clearOtpAndFocus();
        return;
      }

      final token = result.token;
      if (token != null && token.isNotEmpty) {
        await _authStorage.saveToken(token);
      }

      onBeforeNavigate?.call();

      if (result.needsAccountType) {
        Get.offNamed(AppRoutes.profileType);
      } else {
        Get.offNamed(AppRoutes.dashboard);
      }
    } catch (e) {
      isVerifying.value = false;
      Get.snackbar(
        'Verification',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      _clearOtpAndFocus();
    }
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

  Future<void> resendCode() async {
    final phone = _phoneNo;
    if (phone == null || phone.isEmpty) {
      Get.snackbar(
        'Resend',
        'Phone number missing.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    final result = await _api.signIn(phone);
    if (!result.success) {
      Get.snackbar(
        'Resend',
        result.message ?? 'Could not resend code',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    Get.snackbar(
      'OTP',
      result.body?['message']?.toString() ?? 'Code sent',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  void goBack() {
    Get.back();
  }

  @override
  void onClose() {
    for (final node in focusNodes) {
      node.dispose();
    }
    for (final c in textControllers) {
      c.dispose();
    }
    super.onClose();
  }
}
