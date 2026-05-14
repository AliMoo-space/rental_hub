import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

/// Action buttons for product details (Chat, Review, Book Now)
class ProductActionButtonsWidget extends StatelessWidget {
  final VoidCallback? onChat;
  final VoidCallback? onReview;
  final VoidCallback? onBookNow;

  const ProductActionButtonsWidget({
    super.key,
    this.onChat,
    this.onReview,
    this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          // First row: Chat and Review buttons
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: Icons.chat_outlined,
                  label: 'تواصل مع البائع',
                  onPressed: onChat,
                  isPrimary: false,
                ),
              ),
              horizontalSpacing(12),
              Expanded(
                child: _ActionButton(
                  icon: Icons.rate_review_outlined,
                  label: 'اكتب تقييم',
                  onPressed: onReview,
                  isPrimary: false,
                ),
              ),
            ],
          ),
          verticalSpacing(12),
          // Second row: Book Now button (full width)
          _ActionButton(
            icon: Icons.shopping_bag_outlined,
            label: 'استأجر الآن',
            onPressed: onBookNow,
            isPrimary: true,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isFullWidth;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.onPressed,
    this.isPrimary = true,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        height: 50.h,
        child: _buildButton(),
      );
    }
    return _buildButton();
  }

  Widget _buildButton() {
    return Material(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isPrimary ? AppColors.primaryColor : AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(12.r),
            border: isPrimary
                ? null
                : Border.all(color: AppColors.borderColor, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isPrimary
                    ? AppColors.whiteColor
                    : AppColors.primaryColor,
                size: 18.w,
              ),
              horizontalSpacing(6),
              Text(
                label,
                style: AppStyles.bodyMedium.copyWith(
                  color: isPrimary
                      ? AppColors.whiteColor
                      : AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
