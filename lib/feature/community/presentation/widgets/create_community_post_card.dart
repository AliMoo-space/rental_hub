import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_shadows.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/community/presentation/widgets/post_action_chip.dart';

class CreateCommunityPostCard extends StatelessWidget {
  const CreateCommunityPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.createCommunityRequestScreen),
      child: Container(
        width: double.infinity,
        padding: EdgeInsetsDirectional.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [AppShadows.softCard],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.surfaceVariantColor,
                  child: Icon(
                    Icons.person,
                    size: 20.sp,
                    color: AppColors.smallSecondaryColor,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  'هل تود إضافة طلب؟',
                  textAlign: TextAlign.end,
                  style: AppStyles.inputHint.copyWith(
                    color: AppColors.smallSecondaryColor,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Divider(height: 1.h, color: AppColors.borderColor),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: PostActionChip(
                    label: 'صورة',
                    icon: Icons.image_outlined,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: PostActionChip(
                    label: 'حدد السعر',
                    icon: Icons.payments_outlined,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: PostActionChip(
                    label: 'مدة الإيجار',
                    icon: Icons.calendar_month_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
