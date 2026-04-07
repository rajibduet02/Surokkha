import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';
import '../../../core/services/api_service.dart';

/// Login form state: phone number, focus, and navigate to OTP.
/// Phone text is owned by [AuthScreen]'s State to avoid "used after dispose" when re-entering auth.
class AuthController extends GetxController {
  final phoneNumber = ''.obs;
  final isFocused = false.obs;
  final isSigningIn = false.obs;
  VoidCallback? onBeforeNavigate;

  late final ApiService _api;

  @override
  void onInit() {
    super.onInit();
    _api = Get.find<ApiService>();
  }

  void setOnBeforeNavigate(VoidCallback cb) {
    onBeforeNavigate = cb;
  }

  bool get canContinue => phoneNumber.value.length >= 10;

  /// Local BD mobile for API (`017...`), matching backend `phone_no`.
  String get phoneNoForApi {
    final d = phoneNumber.value;
    if (d.length == 10 && !d.startsWith('0')) return '0$d';
    return d;
  }

  void setPhoneNumber(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length <= 11) {
      phoneNumber.value = digitsOnly;
    }
  }

  void setFocused(bool value) => isFocused.value = value;

  void navigateToOtp() {
    if (!canContinue) return;

    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (Get.currentRoute != AppRoutes.otp) {
        Get.toNamed(
          AppRoutes.otp,
          arguments: {'phone_no': phoneNoForApi},
        );
      }
    });
  }

  /// Calls sign-in API then opens OTP on success.
  Future<void> signInAndContinue() async {
    if (!canContinue || isSigningIn.value) return;

    isSigningIn.value = true;
    try {
      final result = await _api.signIn(phoneNoForApi);
      if (!result.success) {
        Get.snackbar(
          'Sign in',
          result.message ?? 'Request failed',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
        return;
      }
      navigateToOtp();
    } finally {
      isSigningIn.value = false;
    }
  }
}
