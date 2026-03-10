import 'package:get/get.dart';

import '../../presentation/otp/controllers/otp_controller.dart';

/// Dependency injection for OTP screen.
class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OtpController>(OtpController(), permanent: false);
  }
}
