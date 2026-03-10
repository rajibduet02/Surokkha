/// Animation durations and curves — aligns with React design system.
abstract class AppAnimations {
  AppAnimations._();

  static const Duration short = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration long = Duration(milliseconds: 500);

  /// Standard transition (transition-all duration-300).
  static const Duration standard = Duration(milliseconds: 300);

  /// SOS pulse / glow repeat duration (2s in React).
  static const Duration pulseCycle = Duration(seconds: 2);
}
