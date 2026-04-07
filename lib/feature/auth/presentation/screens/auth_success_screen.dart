import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              HeightSpace(28),
              Text(
                'Password Updated',
                style: AppStyles.primaryHeadLinesStyle.copyWith(
                  color: Colors.black,
                  fontSize: 32.sp,
                ),
                textAlign: TextAlign.center,
              ),
              HeightSpace(12),
              Text(
                'Your password has been reset successfully. You can now log in with your new password.',
                style: AppStyles.subtitlesStyles,
                textAlign: TextAlign.center,
              ),
              HeightSpace(36),
              PrimaryButtonWidget(
                buttonText: 'Back to Login',
                onPress: () {
                  context.goNamed(AppRoutes.animatedAuthToggle);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
