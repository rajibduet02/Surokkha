import 'package:get/get.dart';

import '../../presentation/safe_zones/controllers/safe_zones_controller.dart';

class SafeZonesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SafeZonesController>(() => SafeZonesController());
  }
}
