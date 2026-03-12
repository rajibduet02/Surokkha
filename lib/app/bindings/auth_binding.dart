import 'package:get/get.dart';

import '../../presentation/auth/controllers/auth_controller.dart';

/// Dependency injection for Auth screen.
/// Ensures a fresh controller when re-entering auth (e.g. after Sign Out) to avoid
/// using a disposed TextEditingController.
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<AuthController>()) {
      Get.delete<AuthController>(force: true);
    }
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
