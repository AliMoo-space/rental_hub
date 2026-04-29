import 'package:flutter/material.dart';

/// App design tokens: colors (concise)
class AppColors {
  // Primary
  static const Color primaryColor = Color(0xff6A72F5);
  static const Color primarySoftColor = Color(0xffCBCEFF);

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

  // Semantic
  static const Color successColor = Color(0xff16A34A);
  static const Color errorColor = Color(0xffDC2626);
  static const Color warningColor = Color(0xffF59E0B);

  // Inputs & components
  static const Color inputHintColor = textSecondaryColor;
  static const Color inputFillColor = surfaceColor;
  static const Color toggleBackgroundColor = surfaceVariantColor;
  static const Color toggleShadowColor = Color(0xffB8BEC7);
  static const Color disabledColor = textMutedColor;
  static const Color bottomNavigationInactiveColor = textMutedColor;
  static const Color bottomNavigationActiveColor = primaryColor;

  // Aliases
  static const Color primary = primaryColor;
  static const Color primarySoft = primarySoftColor;
  static const Color secondary = secondaryColor;
  static const Color textPrimary = textPrimaryColor;
  static const Color textSecondary = textSecondaryColor;
  static const Color textMuted = textMutedColor;
  static const Color surface = surfaceColor;
  static const Color surfaceVariant = surfaceVariantColor;
  static const Color border = borderColor;
  static const Color blackColor = textPrimaryColor;
  static const Color whiteColor = Colors.white;

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
