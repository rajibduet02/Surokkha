/// Border radius — matches React theme.css / DESIGN_SYSTEM.md.
abstract class AppRadius {
  AppRadius._();

  /// Small: 16px — small cards, inputs.
  static const double sm = 16;

  /// Medium: 20px — standard cards, primary buttons.
  static const double md = 20;

  /// Large: 24px — large cards, modals.
  static const double lg = 24;

  /// XLarge: 32px — hero sections.
  static const double xl = 32;

  /// Default radius (1.25rem = 20px).
  static const double radius = 20;
}
