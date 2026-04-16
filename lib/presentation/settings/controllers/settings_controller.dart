import 'package:get/get.dart';

/// Settings state: language, theme toggles, notifications, safety preferences (UI-level).
class SettingsController extends GetxController {
  final RxString selectedLanguage = 'english'.obs; // 'english' | 'bangla'

  final RxBool locationSharing = true.obs;

  final RxBool pushNotifications = true.obs;
  final RxBool smsAlerts = true.obs;
  final RxBool emergencyAlerts = true.obs;
  final RxBool soundEnabled = true.obs;
  final RxBool vibrationEnabled = true.obs;

  /// UI-only; does not switch app theme yet.
  final RxBool darkModeEnabled = true.obs;

  void setLanguage(String lang) {
    selectedLanguage.value = lang;
  }
}
