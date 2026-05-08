import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class DealsToolbarSearchField extends StatelessWidget {
  const DealsToolbarSearchField({super.key, required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            size: 20.sp,
            color: AppColors.smallSecondaryColor,
          ),
          WidthSpace(8),
          Expanded(
            child: Text(
              hintText,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.instrumentSans500Size14.copyWith(
                color: AppColors.smallSecondaryColor,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DealsFilterChip extends StatelessWidget {
  const DealsFilterChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_month_rounded,
            size: 18.sp,
            color: AppColors.smallSecondaryColor,
          ),
          WidthSpace(8),
          Text(
            label,
            style: AppStyles.instrumentSans500Size14.copyWith(
              color: AppColors.smallSecondaryColor,
              fontSize: 13.sp,
            ),
          ),
          WidthSpace(4),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20.sp,
            color: AppColors.smallSecondaryColor,
          ),
        ],
      ),
    );
  }
}

class DealsSectionTitle extends StatelessWidget {
  const DealsSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Text(
        title,
        textAlign: TextAlign.right,
        style: AppStyles.instrumentSans700Size24.copyWith(
          color: AppColors.secondaryColor,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}

class DealsCompactItemTile extends StatelessWidget {
  const DealsCompactItemTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 10.h),
      padding: EdgeInsetsDirectional.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: SizedBox(
              width: 56.w,
              height: 56.w,
              child: Image.asset(AppAssets.modernChair, fit: BoxFit.cover),
            ),
          ),
          WidthSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.instrumentSans700Size18.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 15.sp,
                  ),
                ),
                HeightSpace(2),
                Text(
                  subtitle,
                  style: AppStyles.instrumentSans500Size14.copyWith(
                    fontSize: 12.sp,
                  ),
                ),
                HeightSpace(4),
                Text(
                  price,
                  style: AppStyles.instrumentSans700Size18.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          WidthSpace(8),
          IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.add_shopping_cart_outlined,
              size: 22.sp,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
