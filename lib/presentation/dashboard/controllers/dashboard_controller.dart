import 'package:get/get.dart';

/// Dashboard state: user profile, night mode, greeting.
/// Set [userProfileName] and [profileType] from ProfileTypeScreen on continue.
class DashboardController extends GetxController {
  final RxString userProfileName = 'Woman User'.obs;
  final RxString profileType = 'woman'.obs; // 'woman' | 'child'
  final RxBool isNightMode = false.obs;

  String get greeting => _greetingForHour(DateTime.now().hour);

  bool get isChild => profileType.value == 'child';
  bool get isWoman => profileType.value == 'woman';

  /// Call after profile type selection (e.g. from ProfileTypeScreen).
  void setUserProfile({required String name, required String type}) {
    userProfileName.value = name;
    profileType.value = type;
  }

  void toggleNightMode() => isNightMode.toggle();

  static String _greetingForHour(int hour) {
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }
}
