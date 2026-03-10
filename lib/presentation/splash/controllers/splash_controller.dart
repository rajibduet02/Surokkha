import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';

/// Splash logic: show for 3s then navigate to Onboarding1.
/// Flow: Splash (3s) → Onboarding1 → Onboarding2 (Continue) → Onboarding3 (Continue).
class SplashController extends GetxController {
  Timer? _timer;
  VoidCallback? onBeforeNavigate;

  void setOnBeforeNavigate(VoidCallback cb) {
    onBeforeNavigate = cb;
  }

  @override
  void onReady() {
    super.onReady();
    _timer = Timer(const Duration(seconds: 3), () {
      onBeforeNavigate?.call();
      if (Get.currentRoute != AppRoutes.onboarding1) {
        Get.offNamed(AppRoutes.onboarding1);
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
