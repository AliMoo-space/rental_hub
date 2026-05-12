import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_fonts.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: GoTransitions.openUpwards,
        TargetPlatform.iOS: GoTransitions.cupertino,
        TargetPlatform.macOS: GoTransitions.cupertino,
      },
    ),
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    fontFamily: AppFonts.mainFontName,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      surface: AppColors.surfaceColor,
      error: AppColors.errorColor,
      onPrimary: AppColors.whiteColor,
      onSecondary: AppColors.whiteColor,
      onSurface: AppColors.textPrimaryColor,
      onError: AppColors.whiteColor,
    ),
    textTheme: TextTheme(
      displayLarge: AppStyles.displayLarge,
      displayMedium: AppStyles.displayMedium,
      headlineMedium: AppStyles.headlineMedium,
      headlineSmall: AppStyles.headlineSmall,
      titleLarge: AppStyles.titleMedium,
      titleMedium: AppStyles.bodyLarge,
      bodyLarge: AppStyles.bodyLarge,
      bodyMedium: AppStyles.bodyMedium,
      bodySmall: AppStyles.bodySmall,
      labelLarge: AppStyles.buttonLabel,
      labelMedium: AppStyles.bodyMedium,
      labelSmall: AppStyles.labelSmall,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      disabledColor: AppColors.secondaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        textStyle: AppStyles.buttonLabel,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.r),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.r),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.r),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.r),
        borderSide: const BorderSide(color: AppColors.errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.r),
        borderSide: const BorderSide(color: AppColors.errorColor),
      ),
      hintStyle: AppStyles.inputHint,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.primaryColor;
        }
        return AppColors.whiteColor;
      }),
      checkColor: MaterialStateProperty.all(AppColors.whiteColor),
      side: const BorderSide(color: AppColors.borderColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.bottomNavigationActiveColor,
      unselectedItemColor: AppColors.bottomNavigationInactiveColor,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.smallSecondaryColor),
      scrolledUnderElevation: 0,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: GoTransitions.openUpwards,
        TargetPlatform.iOS: GoTransitions.cupertino,
        TargetPlatform.macOS: GoTransitions.cupertino,
      },
    ),
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: const Color(0xFF0F1724),
    fontFamily: AppFonts.mainFontName,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.smallSecondaryColor,
      surface: const Color(0xFF111827),
      error: AppColors.errorColor,
      onPrimary: AppColors.whiteColor,
      onSecondary: AppColors.whiteColor,
      onSurface: const Color(0xFFE6EEF6),
      onError: AppColors.whiteColor,
    ),
    textTheme: TextTheme(
      displayLarge: AppStyles.displayLarge.copyWith(
        color: const Color(0xFFE6EEF6),
      ),
      displayMedium: AppStyles.displayMedium.copyWith(
        color: const Color(0xFFE6EEF6),
      ),
      headlineMedium: AppStyles.headlineMedium.copyWith(
        color: const Color(0xFFDDE9FF),
      ),
      headlineSmall: AppStyles.headlineSmall.copyWith(
        color: const Color(0xFFDDE9FF),
      ),
      titleLarge: AppStyles.titleMedium.copyWith(
        color: const Color(0xFFE6EEF6),
      ),
      titleMedium: AppStyles.bodyLarge.copyWith(color: const Color(0xFFE6EEF6)),
      bodyLarge: AppStyles.bodyLarge.copyWith(color: const Color(0xFFB9C6D9)),
      bodyMedium: AppStyles.bodyMedium.copyWith(color: const Color(0xFFB9C6D9)),
      bodySmall: AppStyles.bodySmall.copyWith(color: const Color(0xFFA8B4C6)),
      labelLarge: AppStyles.buttonLabel.copyWith(color: AppColors.whiteColor),
      labelMedium: AppStyles.bodyMedium.copyWith(
        color: const Color(0xFFB9C6D9),
      ),
      labelSmall: AppStyles.labelSmall.copyWith(color: const Color(0xFFA8B4C6)),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      disabledColor: AppColors.secondaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        textStyle: AppStyles.buttonLabel,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF0B1220),
      contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.r),
        borderSide: const BorderSide(color: Color(0xFF24303D)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.r),
        borderSide: const BorderSide(color: Color(0xFF24303D)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.r),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.r),
        borderSide: const BorderSide(color: AppColors.errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.r),
        borderSide: const BorderSide(color: AppColors.errorColor),
      ),
      hintStyle: AppStyles.inputHint.copyWith(color: const Color(0xFF9AAABF)),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.primaryColor;
        }
        return const Color(0xFF444444);
      }),
      checkColor: MaterialStateProperty.all(AppColors.whiteColor),
      side: const BorderSide(color: Color(0xFF24303D)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF0B1220),
      selectedItemColor: AppColors.bottomNavigationActiveColor,
      unselectedItemColor: AppColors.bottomNavigationInactiveColor,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Color(0xFF0B1220),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white70),
      scrolledUnderElevation: 0,
    ),
  );
}
