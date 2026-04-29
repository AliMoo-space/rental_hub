import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_fonts.dart';

/// App typography tokens (concise)
/// Use semantic names (`displayLarge`, `bodyMedium`, `labelSmall`) across the app.
class AppStyles {
  /// Helper to create TextStyle with responsive sizing
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

  // Display styles (hero and page titles)
  static TextStyle get displayLarge => _style(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.15,
    letterSpacing: -0.4,
  );

  // Display medium (secondary hero/title)
  static TextStyle get displayMedium => _style(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    fontFamily: AppFonts.mainFontWeight,
    height: 1.2,
    letterSpacing: -0.2,
  );

  // Heading styles (section headers)
  static TextStyle get headlineMedium => _style(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.2,
  );

  // Heading small
  static TextStyle get headlineSmall => _style(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    fontFamily: AppFonts.mainFontWeight,
    height: 1.25,
  );

  // Title styles
  static TextStyle get titleMedium => _style(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  // Body styles (main content)
  static TextStyle get bodyLarge => _style(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.45,
  );

  // Standard body
  static TextStyle get bodyMedium => _style(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.45,
  );

  // Small body
  static TextStyle get bodySmall => _style(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // Label & caption styles
  static TextStyle get labelSmall => _style(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: 0.2,
  );

  // Interactive & semantic styles
  static TextStyle get inputLabel => labelSmall;

  /// Input Hint: Based on bodyMedium (#8391A1), lighter weight (w300)
  /// Placeholder and hint text within input fields
  /// Reduced font weight (w300) indicates non-committed content
  /// Used for: Input placeholders, hint text, helper messages in fields
  static TextStyle get inputHint => bodyMedium.copyWith(
    color: AppColors.inputHintColor,
    fontWeight: FontWeight.w300,
  );

  // Link text
  static TextStyle get linkText => bodySmall.copyWith(
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  );

  // Button label
  static TextStyle get buttonLabel => bodyMedium.copyWith(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  // Legacy aliases (kept for compatibility)
  static TextStyle get primaryHeadLinesStyle => displayLarge;

  /// Subtitle alias
  static TextStyle get subtitlesStyles => bodyLarge.copyWith(
    color: AppColors.secondaryColor,
    fontWeight: FontWeight.w400,
  );

  /// Alias: Black text 16sp medium (uses bodyLarge)
  /// Legacy name - prefer [bodyLarge] for new code
  static TextStyle get black16w500Style => bodyLarge;

  /// Alias: Grey text 12sp medium (uses bodySmall)
  /// Legacy name - prefer [bodySmall] for new code
  static TextStyle get grey12MediumStyle => bodySmall;

  /// Alias: Black text 10sp bold (uses labelSmall)
  /// Legacy name - prefer [labelSmall] for new code
  static TextStyle get black10BoldStyle => labelSmall;

  /// Alias: Black text 18sp bold (uses titleMedium)
  /// Legacy name - prefer [titleMedium] for new code
  static TextStyle get black18BoldStyle => titleMedium;

  /// Alias: Intro text 32sp semibold (uses displayMedium)
  /// Legacy name - prefer [displayMedium] for new code
  static TextStyle get intro32semiBold => displayMedium;

  /// Alias: Intro text 16sp normal weight with small secondary color
  /// Uses HindSiliguri font family
  /// Legacy name - prefer [bodyLarge] for new code
  static TextStyle get intro16medium => bodyLarge.copyWith(
    fontFamily: AppFonts.mainFontWeight,
    fontWeight: FontWeight.w400,
    color: AppColors.smallSecondaryColor,
  );

  /// Alias: Heading 20sp (uses headlineSmall)
  /// Legacy name - prefer [headlineSmall] for new code
  static TextStyle get hendi500Size20 => headlineSmall;

  /// Alias: InstrumentSans font 14sp medium with small secondary color
  /// Legacy name for custom instrument sans styling
  static TextStyle get instrumentSans500Size14 => bodyMedium.copyWith(
    fontFamily: AppFonts.instrumentSans,
    color: AppColors.smallSecondaryColor,
  );

  /// Alias: InstrumentSans font 18sp bold with small secondary color
  /// Legacy name for custom instrument sans styling
  static TextStyle get instrumentSans700Size18 => titleMedium.copyWith(
    fontFamily: AppFonts.instrumentSans,
    color: AppColors.smallSecondaryColor,
  );

  /// Alias: InstrumentSans font 24sp bold with small secondary color
  /// Legacy name for custom instrument sans styling
  static TextStyle get instrumentSans700Size24 => headlineMedium.copyWith(
    fontFamily: AppFonts.instrumentSans,
    color: AppColors.smallSecondaryColor,
  );
}
