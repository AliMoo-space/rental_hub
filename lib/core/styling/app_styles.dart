import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_fonts.dart';

class AppStyles {
  static TextStyle _style({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    String? fontFamily,
    double height = 1.4,
    double letterSpacing = 0,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.mainFontName,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  // ================= DISPLAY =================
  static TextStyle get displayLarge => _style(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.15,
    letterSpacing: -0.4,
  );

  static TextStyle get displayMedium => _style(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    height: 1.2,
    letterSpacing: -0.2,
  );

  // ================= HEADINGS =================
  static TextStyle get headlineMedium => _style(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get headlineSmall => _style(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static TextStyle get titleMedium => _style(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  // ================= BODY =================
  static TextStyle get bodyLarge => _style(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.45,
  );

  static TextStyle get bodyMedium => _style(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.45,
  );

  static TextStyle get bodySmall => _style(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // ================= LABEL =================
  static TextStyle get labelSmall => _style(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 0.2,
  );

  // ================= SPECIAL =================
  static TextStyle get inputHint => bodyMedium.copyWith(
    color: AppColors.inputHintColor,
    fontWeight: FontWeight.w300,
  );

  static TextStyle get linkText => bodySmall.copyWith(
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  );

  static TextStyle get buttonLabel => bodyMedium.copyWith(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get subtitlesStyles => bodyLarge.copyWith(
    color: AppColors.secondaryColor,
    fontWeight: FontWeight.w400,
  );

  // ================= LEGACY (MINIMAL ONLY) =================
  static TextStyle get primaryHeadLinesStyle => displayLarge;

  static TextStyle get black16w500Style => bodyLarge;

  static TextStyle get grey12MediumStyle => bodySmall;

  static TextStyle get black10BoldStyle => labelSmall;

  static TextStyle get black18BoldStyle => titleMedium;

  static TextStyle get intro32semiBold => displayMedium;

  static TextStyle get hendi500Size20 => headlineSmall;

  // ================= CUSTOM FONTS =================
  static TextStyle get intro16medium => bodyLarge.copyWith(
    fontFamily: AppFonts.instrumentSans,
    fontWeight: FontWeight.w400,
    color: AppColors.smallSecondaryColor,
  );

  static TextStyle get instrumentSans500Size14 => bodyMedium.copyWith(
    fontFamily: AppFonts.instrumentSans,
    color: AppColors.smallSecondaryColor,
  );

  static TextStyle get instrumentSans700Size18 => titleMedium.copyWith(
    fontFamily: AppFonts.instrumentSans,
    color: AppColors.smallSecondaryColor,
  );

  static TextStyle get instrumentSans700Size24 => headlineMedium.copyWith(
    fontFamily: AppFonts.instrumentSans,
    color: AppColors.smallSecondaryColor,
  );
}
