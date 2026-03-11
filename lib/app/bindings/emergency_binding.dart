import 'package:get/get.dart';

import '../../presentation/emergency/controllers/emergency_controller.dart';

class EmergencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmergencyController>(() => EmergencyController());
  }
}
