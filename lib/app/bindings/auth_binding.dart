import 'package:get/get.dart';

import '../../presentation/auth/controllers/auth_controller.dart';

/// Dependency injection for Auth screen.
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
