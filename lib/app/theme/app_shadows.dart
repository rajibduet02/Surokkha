import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Shadow depth — matches React theme.css / DESIGN_SYSTEM.md.
abstract class AppShadows {
  AppShadows._();

  /// Subtle elevation: 0 2px 8px rgba(0,0,0,0.2)
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  /// Medium elevation: 0 4px 16px rgba(0,0,0,0.3)
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x4D000000),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  /// High elevation: 0 8px 24px rgba(0,0,0,0.4)
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x66000000),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  /// Gold glow: 0 8px 24px rgba(212, 175, 55, 0.3)
  static List<BoxShadow> get gold => [
        BoxShadow(
          color: AppColors.goldGlow,
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  /// Legacy alias
  static const List<BoxShadow> card = sm;
}
