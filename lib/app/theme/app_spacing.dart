/// 8pt grid spacing system — matches React theme.css / DESIGN_SYSTEM.md.
/// All spacing uses multiples of 8px.
abstract class AppSpacing {
  AppSpacing._();

  static const double spacing1 = 8;   // space-2
  static const double spacing2 = 16;  // space-4
  static const double spacing3 = 24;  // space-6 — standard horizontal padding
  static const double spacing4 = 32; // space-8
  static const double spacing5 = 40;  // space-10
  static const double spacing6 = 48;  // space-12

  /// Standard horizontal padding for screens (24px).
  static const double screenPaddingHorizontal = spacing3;

  /// Standard horizontal padding for cards (24px).
  static const double cardPadding = spacing3;

  /// Bottom padding for screens with floating nav (pb-32).
  static const double bottomNavPadding = 128;
}
