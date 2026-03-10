import 'package:get/get.dart';

import '../../presentation/dashboard/controllers/dashboard_controller.dart';

/// Dependency injection for Home screen.
class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
