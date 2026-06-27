import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_shadows.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/community/domain/entities/community_request_entity.dart';
import 'package:rental_hub/feature/community/presentation/widgets/community_time_label.dart';
import 'package:rental_hub/feature/community/presentation/widgets/info_tag.dart';

class CommunityRequestCard extends StatelessWidget {
  final CommunityRequestEntity request;
  final VoidCallback? onSubmitOffer;
  final VoidCallback? onTap;
  final bool showSubmitButton;
  final bool isCompact;

  const CommunityRequestCard({
    super.key,
    required this.request,
    this.onSubmitOffer,
    this.onTap,
    this.showSubmitButton = true,
    this.isCompact = false,
  });

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
      case 'pending':
        return AppColors.primaryColor;
      case 'approved':
      case 'active':
        return Colors.green;
      case 'rejected':
      case 'closed':
        return Colors.red;
      default:
        return AppColors.smallSecondaryColor;
    }
  }

  String _statusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'open':
      case 'pending':
        return 'مفتوح';
      case 'approved':
      case 'active':
        return 'نشط';
      case 'rejected':
      case 'closed':
        return 'مغلق';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = request.description.trim().isEmpty
        ? request.title
        : request.description;
    final hasImage = request.imageUrl != null && request.imageUrl!.isNotEmpty;
    final hasUserImage =
        request.userImageUrl != null && request.userImageUrl!.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsetsDirectional.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.borderColor.withValues(alpha: 0.5),
          ),
          boxShadow: [AppShadows.softCard],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: AppColors.surfaceVariantColor,
                  backgroundImage: hasUserImage
                      ? NetworkImage(request.userImageUrl!)
                      : null,
                  child: hasUserImage
                      ? null
                      : Icon(
                          Icons.person,
                          size: 18.sp,
                          color: AppColors.smallSecondaryColor,
                        ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (request.userFullName.trim().isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Text(
                            request.userFullName,
                            style: AppStyles.hendi500Size20.copyWith(
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      if (request.locationLabel.isNotEmpty)
                        Text(
                          request.userFullName,
                          style: AppStyles.bodySmall.copyWith(
                            color: AppColors.smallSecondaryColor,
                            fontSize: 11.sp,
                          ),
                        ),
                    ],
                  ),
                ),
                if (request.status.isNotEmpty)
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(
                        request.status,
                      ).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      _statusLabel(request.status),
                      style: AppStyles.bodySmall.copyWith(
                        color: _statusColor(request.status),
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
              ],
            ),
            if (hasImage) ...[
              SizedBox(height: 10.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  request.imageUrl!,
                  width: double.infinity,
                  height: 160.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _imagePlaceholder(),
                  loadingBuilder: (_, child, progress) =>
                      progress == null ? child : _imageLoading(),
                ),
              ),
            ] else ...[
              SizedBox(height: 10.h),
              _imagePlaceholder(),
            ],
            SizedBox(height: 10.h),
            Text(
              request.title,
              style: AppStyles.hendi500Size20.copyWith(fontSize: 16.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (body != request.title) ...[
              SizedBox(height: 4.h),
              Text(
                body,
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.smallSecondaryColor,
                  height: 1.6,
                  fontSize: 13.sp,
                ),
              ),
            ],
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                if (request.locationLabel.isNotEmpty)
                  InfoTag(
                    icon: Icons.location_on_outlined,
                    text: request.locationLabel,
                  ),
                InfoTag(
                  icon: Icons.access_time,
                  text: communityTimeLabel(request.createdAt),
                ),
                if (request.budget > 0)
                  InfoTag(
                    icon: Icons.payments_outlined,
                    text:
                        '${request.budget.toStringAsFixed(0)} ${context.l10n.egpCurrency}',
                  ),
                if (request.offersCount > 0)
                  InfoTag(
                    icon: Icons.chat_bubble_outline,
                    text:
                        '${request.offersCount} ${context.l10n.offersCountLabel}',
                  ),
              ],
            ),
            if (showSubmitButton) ...[
              SizedBox(height: 14.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSubmitOffer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    context.l10n.submitOffer,
                    style: AppStyles.buttonLabel.copyWith(fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 160.h,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariantColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 48.sp,
          color: AppColors.smallSecondaryColor,
        ),
      ),
    );
  }

  Widget _imageLoading() {
    return Container(
      width: double.infinity,
      height: 160.h,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariantColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}
