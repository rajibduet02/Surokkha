import 'package:flutter/material.dart';

/// Dark luxury theme colors — matches React theme.css / Figma design system.
/// Background: #0A0A0F, Gold accents: #D4AF37 / #F6D365.
abstract class AppColors {
  AppColors._();

  // --- Background & Surface ---
  static const Color background = Color(0xFF0A0A0F);
  static const Color backgroundSecondary = Color(0xFF1A1A22);
  static const Color foreground = Color(0xFFFFFFFF);

  // --- Gold Accents ---
  static const Color goldPrimary = Color(0xFFD4AF37);
  static const Color goldSecondary = Color(0xFFF6D365);
  static Color get goldGlow => goldPrimary.withValues(alpha: 0.3);

  // --- Card & Popover ---
  static const Color card = Color(0xFF1A1A22);
  static const Color cardForeground = Color(0xFFFFFFFF);
  static const Color popover = Color(0xFF1A1A22);
  static const Color popoverForeground = Color(0xFFFFFFFF);

  // --- Primary (Gold) ---
  static const Color primary = Color(0xFFD4AF37);
  static const Color primaryForeground = Color(0xFF0A0A0F);

  // --- Secondary & Muted ---
  static const Color secondary = Color(0xFF2A2A32);
  static const Color secondaryForeground = Color(0xFFFFFFFF);
  static const Color muted = Color(0xFF2A2A32);
  static const Color mutedForeground = Color(0xFF8A8A92);

  // --- Accent ---
  static const Color accent = Color(0xFFD4AF37);
  static const Color accentForeground = Color(0xFF0A0A0F);

  // --- Destructive & Status ---
  static const Color destructive = Color(0xFFEF4444);
  static const Color destructiveForeground = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);

  // --- Border & Input ---
  static Color get border => goldPrimary.withValues(alpha: 0.1);
  static Color get input => const Color(0xFFFFFFFF).withValues(alpha: 0.05);
  static Color get inputBackground => const Color(0xFFFFFFFF).withValues(alpha: 0.05);
  static const Color switchBackground = Color(0xFF2A2A32);
  static Color get ring => goldPrimary.withValues(alpha: 0.5);

  // --- Text Hierarchy (from design system) ---
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFCFCFCF);
  static const Color textMuted = Color(0xFF8A8A92);

  // --- Charts / Sidebar (for consistency) ---
  static const Color chart1 = Color(0xFFD4AF37);
  static const Color chart2 = Color(0xFFF6D365);
  static const Color chart3 = Color(0xFF8A8A92);
  static const Color chart4 = Color(0xFF2A2A32);
  static const Color chart5 = Color(0xFF1A1A22);
}
