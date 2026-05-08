import 'package:flutter/material.dart';

/// App design tokens: colors (concise)
class AppColors {
  // Primary
  static const Color primaryColor = Color(0xff6A72F5);
  static const Color primarySoftColor = Color(0xffCBCEFF);
  static const Color primaryDarkColor = Color(0xffDADCFF);

  // Secondary / neutrals
  static const Color secondaryColor = Color(0xff797979);
  static const Color smallSecondaryColor = Color(0xffB0B0B0);

  // Text
  static const Color textPrimaryColor = Color(0xff1F2C37);
  static const Color textSecondaryColor = Color(0xff8391A1);
  static const Color textMutedColor = Color(0xff9AA3B2);

  // Surfaces
  static const Color surfaceColor = Color(0xffF7F8F9);
  static const Color surfaceVariantColor = Color(0xffECEEF1);
  static const Color backgroundColor = Color(0xffE6E6E6);

  // Borders
  static const Color borderColor = Color(0xffE8ECF4);

  // Utility
  static const Color whiteColor = Color(0xFFFFFFFF);

  // Bottom navigation
  static const Color bottomNavigationActiveColor = Color(0xff6A72F5);
  static const Color bottomNavigationInactiveColor = Color(0xffB0B0B0);

  // Text aliases (legacy/semantic names used across the app)
  static const Color textPrimary = textPrimaryColor;
  static const Color textSecondary = textSecondaryColor;

  // Input / control colors
  static const Color inputHintColor = textSecondaryColor;

  // Toggle / segmented control background
  static const Color toggleBackgroundColor = surfaceVariantColor;

  // Semantic
  static const Color successColor = Color(0xff16A34A);
  static const Color errorColor = Color(0xffDC2626);
  static const Color warningColor = Color(0xffF59E0B);

  // Decorative palette
  static const List<Color> colorPalette = [
    Color(0xFF9FFFF6),
    Color(0xFF8DCFF6),
    Color(0xFF7DA6F5),
    Color(0xFF6A72F5),
    Color(0xFFA27AD2),
    Color(0xFFFFA6B7),
  ];
}
