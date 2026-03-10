import 'package:get/get.dart';

import '../bindings/auth_binding.dart';
import '../bindings/dashboard_binding.dart';
import '../bindings/otp_binding.dart';
import '../bindings/settings_binding.dart';
import '../bindings/splash_binding.dart';
import '../../presentation/auth/views/auth_screen.dart';
import '../../presentation/dashboard/views/dashboard_screen.dart';
import '../../presentation/otp/views/otp_screen.dart';
import '../../presentation/profile_type/views/profile_type_screen.dart';
import '../../presentation/settings/views/settings_screen.dart';
import '../../presentation/onboarding/views/onboarding1_screen.dart';
import '../../presentation/onboarding/views/onboarding2_screen.dart';
import '../../presentation/onboarding/views/onboarding3_screen.dart';
import '../../presentation/splash/views/splash_screen.dart';

part 'app_routes.dart';

/// GetPage definitions for GetX named routing.
abstract class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.onboarding1,
      page: () => const Onboarding1Screen(),
    ),
    GetPage(
      name: _Paths.onboarding2,
      page: () => const Onboarding2Screen(),
    ),
    GetPage(
      name: _Paths.onboarding3,
      page: () => const Onboarding3Screen(),
    ),
    GetPage(
      name: _Paths.auth,
      page: () => const AuthScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.otp,
      page: () => const OtpScreen(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.profileType,
      page: () => const ProfileTypeScreen(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.settings,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
    ),
  ];
}
