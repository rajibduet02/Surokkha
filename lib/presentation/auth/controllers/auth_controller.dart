import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';

/// Login form state: phone number, focus, and navigate to OTP.
class AuthController extends GetxController {
  final phoneNumber = ''.obs;
  final isFocused = false.obs;
  final phoneController = TextEditingController();
  VoidCallback? onBeforeNavigate;

  void setOnBeforeNavigate(VoidCallback cb) {
    onBeforeNavigate = cb;
  }

  bool get canContinue => phoneNumber.value.length >= 10;

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
        Get.toNamed(AppRoutes.otp);
      }
    });
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
