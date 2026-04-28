import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class AuthSuccessScreen extends StatelessWidget {
  const AuthSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Success Icon
                Container(
                  width: 92.w,
                  height: 92.h,
                  decoration: const BoxDecoration(
                    color: Color(0xffEAF5FF),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    color: AppColors.primaryColor,
                    size: 40.sp,
                  ),
                ),
                HeightSpace(28.h),

                // Success Title
                Text(
                  context.l10n.passwordUpdated,
                  style: AppStyles.primaryHeadLinesStyle.copyWith(
                    color: Colors.black,
                    fontSize: 32.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                HeightSpace(12.h),

                // Success Message
                Text(
                  context.l10n.passwordUpdateSuccess,
                  style: AppStyles.subtitlesStyles.copyWith(fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
                HeightSpace(36.h),

                // Back to Login Button
                PrimaryButtonWidget(
                  buttonText: context.l10n.backToLogin,
                  onPress: () {
                    context.goNamed(AppRoutes.animatedAuthToggle);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
