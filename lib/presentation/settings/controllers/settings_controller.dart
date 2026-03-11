import 'package:get/get.dart';

/// Settings state: language selection, theme, logout.
class SettingsController extends GetxController {
  final RxString selectedLanguage = 'english'.obs; // 'english' | 'bangla'

  void setLanguage(String lang) {
    selectedLanguage.value = lang;
  }
}
