import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class ProfileEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const ProfileEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColors.primarySoftColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 36.sp, color: AppColors.primaryColor),
            ),
            HeightSpace(20),
            Text(
              title,
              style: AppStyles.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              HeightSpace(8),
              Text(
                subtitle!,
                style: AppStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              HeightSpace(24),
              PrimaryButtonWidget(
                buttonText: actionLabel!,
                onPress: onAction,
                width: 200.w,
                height: 44.h,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
