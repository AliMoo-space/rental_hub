import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/app_image.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/product_review_entity.dart';
import 'package:rental_hub/feature/product_reviews/presentation/widgets/star_selector_widget.dart';

class ReviewCardWidget extends StatelessWidget {
  final ProductReviewEntity review;
  final bool isOwner;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isEditLoading;
  final bool isDeleteLoading;

  const ReviewCardWidget({
    super.key,
    required this.review,
    required this.isOwner,
    this.onEdit,
    this.onDelete,
    this.isEditLoading = false,
    this.isDeleteLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Avatar(
                initials: _initialsFor(review.userName),
                imageUrl: review.userImage,
              ),
              horizontalSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            review.userName,
                            style: AppStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (isOwner) ...[
                          _ActionIconButton(
                            icon: Icons.edit_outlined,
                            isLoading: isEditLoading,
                            onTap: onEdit,
                          ),
                          SizedBox(width: 6.w),
                          _ActionIconButton(
                            icon: Icons.delete_outline_rounded,
                            isLoading: isDeleteLoading,
                            onTap: onDelete,
                            destructive: true,
                          ),
                        ],
                      ],
                    ),
                    verticalSpacing(6),
                    StarSelectorWidget(
                      rating: review.score.toDouble(),
                      readOnly: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (review.hasComment) ...[
            verticalSpacing(12),
            Text(
              review.comment ?? '',
              style: AppStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                height: 1.7,
              ),
            ),
          ],
          verticalSpacing(14),
          Text(
            _formatArabicDate(review.createdAt),
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatArabicDate(DateTime dateTime) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    final day = _toArabicDigits(dateTime.day.toString());
    final year = _toArabicDigits(dateTime.year.toString());
    final month = months[dateTime.month - 1];
    return '$day $month $year';
  }

  String _toArabicDigits(String value) {
    const map = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };
    return value.split('').map((char) => map[char] ?? char).join();
  }

  String _initialsFor(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return '؟';
    }
    final first = parts.first.substring(0, 1);
    if (parts.length == 1) {
      return first.toUpperCase();
    }
    final second = parts[1].substring(0, 1);
    return (first + second).toUpperCase();
  }
}

class _Avatar extends StatelessWidget {
  final String initials;
  final String? imageUrl;

  const _Avatar({required this.initials, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surfaceVariantColor,
        border: Border.all(color: AppColors.borderColor),
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl!.trim().isNotEmpty
            ? AppImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                width: 52.w,
                height: 52.w,
              )
            : Center(
                child: Text(
                  initials,
                  style: AppStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
      ),
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  final IconData icon;
  final bool isLoading;
  final bool destructive;
  final VoidCallback? onTap;

  const _ActionIconButton({
    required this.icon,
    required this.isLoading,
    required this.onTap,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: destructive
          ? AppColors.errorColor.withValues(alpha: 0.08)
          : AppColors.primaryColor.withValues(alpha: 0.08),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: isLoading ? null : onTap,
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: isLoading
              ? SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: destructive
                        ? AppColors.errorColor
                        : AppColors.primaryColor,
                  ),
                )
              : Icon(
                  icon,
                  size: 18.sp,
                  color: destructive
                      ? AppColors.errorColor
                      : AppColors.primaryColor,
                ),
        ),
      ),
    );
  }
}
