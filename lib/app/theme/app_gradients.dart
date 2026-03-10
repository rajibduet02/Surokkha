import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Gradients — matches React design system (gold primary CTA, etc.).
abstract class AppGradients {
  AppGradients._();

  /// Primary CTA: gold primary → gold secondary.
  static const LinearGradient primaryGold = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.goldPrimary, AppColors.goldSecondary],
  );

  /// Gold gradient top-left to bottom-right (hero/glow).
  static const LinearGradient goldDiagonal = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.goldPrimary, AppColors.goldSecondary],
  );

  /// Legacy alias
  static const LinearGradient primaryGradient = primaryGold;
}
