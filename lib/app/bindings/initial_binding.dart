import 'package:get/get.dart';

import '../../core/services/api_service.dart';
import '../../core/services/auth_storage_service.dart';
import '../../presentation/notification/controllers/notification_controller.dart';

/// Initial dependency injection binding.
/// Registers global controllers and services at app startup.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ApiService>(ApiService(), permanent: true);
    Get.put<AuthStorageService>(AuthStorageService(), permanent: true);
    Get.put<NotificationController>(NotificationController(), permanent: true);
  }
}
