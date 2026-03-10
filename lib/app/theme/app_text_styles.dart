import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Typography hierarchy — matches React theme.css / DESIGN_SYSTEM.md.
/// H1: 28px Bold, H2: 22px SemiBold, Body: 16px, Caption: 13px.
abstract class AppTextStyles {
  AppTextStyles._();

  static const double fontSizeBase = 16;

  /// H1 - Main headlines (28px Bold). Hero titles, screen titles.
  static const TextStyle h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.25,
    color: AppColors.foreground,
  );

  /// H2 - Section headers (22px SemiBold). Section headings, card titles.
  static const TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.foreground,
  );

  /// Body - Primary text (16px Regular). Main content, descriptions.
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.foreground,
  );

  /// Caption - Secondary text (13px Medium). Labels, metadata, helper text.
  static const TextStyle caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.mutedForeground,
  );

  /// Label (16px Medium). Form labels, buttons.
  static const TextStyle label = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.foreground,
  );

  /// Button text (16px Medium/SemiBold).
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  // Legacy aliases for compatibility
  static const TextStyle headline1 = h1;
  static const TextStyle headline2 = h2;
  static const TextStyle body1 = body;
  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.foreground,
  );
}
