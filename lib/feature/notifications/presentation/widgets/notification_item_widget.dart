import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/notifications/domain/entities/notification_entity.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;

  const NotificationItemWidget({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: notification.isRead ? AppColors.whiteColor : AppColors.primaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: notification.isRead
                ? AppColors.borderColor
                : AppColors.primaryColor.withValues(alpha: 0.2),
            width: 1.w,
          ),
          boxShadow: [
            if (!notification.isRead)
              BoxShadow(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              margin: EdgeInsets.only(top: 6.h, right: 12.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: notification.isRead ? Colors.transparent : AppColors.primaryColor,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: AppStyles.bodyLarge.copyWith(color: AppColors.textPrimaryColor),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    notification.body,
                    style: AppStyles.bodySmall.copyWith(color: AppColors.textSecondaryColor),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    DateFormat('MMM dd, yyyy - hh:mm a').format(notification.createdAt),
                    style: AppStyles.labelSmall.copyWith(
                      color: AppColors.textSecondaryColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
