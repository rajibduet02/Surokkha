import 'package:get/get.dart';

import '../../presentation/settings/controllers/settings_controller.dart';

/// Dependency injection for Settings screen.
class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
