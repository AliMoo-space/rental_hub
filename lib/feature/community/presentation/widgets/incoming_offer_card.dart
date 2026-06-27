import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_shadows.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/community/domain/entities/community_offer_entity.dart';

class IncomingOfferCard extends StatelessWidget {
  final CommunityOfferEntity offer;
  final bool isSubmitting;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const IncomingOfferCard({
    super.key,
    required this.offer,
    required this.isSubmitting,
    required this.onAccept,
    required this.onReject,
  });

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.primaryColor;
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

  Future<void> _confirmAction(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      onConfirm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isResolved =
        offer.status.toLowerCase() == 'accepted' ||
        offer.status.toLowerCase() == 'rejected';

    return Container(
      padding: EdgeInsetsDirectional.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
        boxShadow: [AppShadows.softCard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.surfaceVariantColor,
                child: Icon(
                  Icons.person,
                  size: 16.sp,
                  color: AppColors.smallSecondaryColor,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.offererName,
                      style: AppStyles.hendi500Size20.copyWith(fontSize: 14.sp),
                    ),
                    Text(
                      offer.requestTitle ?? 'طلب #${offer.requestId}',
                      style: AppStyles.bodySmall.copyWith(
                        color: AppColors.smallSecondaryColor,
                        fontSize: 11.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(
                Icons.payments_outlined,
                size: 16.sp,
                color: AppColors.primaryColor,
              ),
              SizedBox(width: 6.w),
              Text(
                '${offer.proposedPrice.toStringAsFixed(0)} ${context.l10n.egpCurrency}',
                style: AppStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          if (offer.message.trim().isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              offer.message,
              style: AppStyles.bodySmall.copyWith(
                color: AppColors.smallSecondaryColor,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (!isResolved) ...[
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: isSubmitting
                        ? null
                        : () => _confirmAction(
                            context,
                            title: 'رفض العرض',
                            message:
                                'هل أنت متأكد من رفض هذا العرض؟ لا يمكن التراجع عن هذا الإجراء.',
                            onConfirm: onReject,
                          ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: const Text('رفض'),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isSubmitting
                        ? null
                        : () => _confirmAction(
                            context,
                            title: 'قبول العرض',
                            message:
                                'هل أنت متأكد من قبول هذا العرض؟ سيتم إعلام مقدم العرض بقرارك.',
                            onConfirm: onAccept,
                          ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: const Text('قبول'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
