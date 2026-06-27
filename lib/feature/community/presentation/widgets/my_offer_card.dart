import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/community/domain/entities/community_offer_entity.dart';

class MyOfferCard extends StatelessWidget {
  final CommunityOfferEntity offer;

  const MyOfferCard({super.key, required this.offer});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return AppColors.smallSecondaryColor;
    }
  }

  String _statusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'قيد الانتظار';
      case 'accepted':
        return 'مقبول';
      case 'rejected':
        return 'مرفوض';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.requestTitle ?? 'طلب #${offer.requestId}',
                  style: AppStyles.hendi500Size20.copyWith(fontSize: 13.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.payments_outlined,
                      size: 14.sp,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${offer.proposedPrice.toStringAsFixed(0)} ${context.l10n.egpCurrency}',
                      style: AppStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 8.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: _statusColor(offer.status).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              _statusLabel(offer.status),
              style: AppStyles.bodySmall.copyWith(
                color: _statusColor(offer.status),
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
