import 'package:get/get.dart';

import '../../presentation/splash/controllers/splash_controller.dart';

/// Dependency injection for Splash screen.
/// Uses put (not lazyPut) so the controller is created immediately when the route loads,
/// ensuring onReady() runs and the 3s timer starts right away.
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(), permanent: false);
  }
}
