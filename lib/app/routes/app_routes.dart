part of 'app_pages.dart';

/// Application route path constants and names.
abstract class AppRoutes {
  AppRoutes._();

  static const splash = _Paths.splash;
  static const onboarding1 = _Paths.onboarding1;
  static const onboarding2 = _Paths.onboarding2;
  static const onboarding3 = _Paths.onboarding3;
  static const main = _Paths.main;
  static const auth = _Paths.auth;
  static const otp = _Paths.otp;
  static const profileType = _Paths.profileType;
  static const dashboard = _Paths.dashboard;
  static const home = _Paths.home;
  static const featureA = _Paths.featureA;
  static const featureB = _Paths.featureB;
  static const settings = _Paths.settings;
}

abstract class _Paths {
  _Paths._();

  static const splash = '/splash';
  static const onboarding1 = '/onboarding-1';
  static const onboarding2 = '/onboarding-2';
  static const onboarding3 = '/onboarding-3';
  static const main = '/main';
  static const auth = '/auth';
  static const otp = '/otp';
  static const profileType = '/profile-type';
  static const dashboard = '/dashboard';
  static const home = '/home';
  static const featureA = '/feature-a';
  static const featureB = '/feature-b';
  static const settings = '/settings';
}
