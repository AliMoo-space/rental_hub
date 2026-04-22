import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_fonts.dart';

class AppStyles {
  static TextStyle primaryHeadLinesStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 36.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );

  static TextStyle subtitlesStyles = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryColor,
  );

  static TextStyle black16w500Style = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  );

  static TextStyle grey12MediumStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryColor,
  );

  static TextStyle black10BoldStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 10.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle black18BoldStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle intro32semiBold = TextStyle(
    fontFamily: AppFonts.mainFontWeight,
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryColor,
  );
  static TextStyle intro16medium = TextStyle(
    fontFamily: AppFonts.mainFontWeight,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.smallSecondaryColor,
  );
  static TextStyle hendi500Size20 = TextStyle(
    fontFamily: AppFonts.mainFontWeight,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteColor,
  );
}
