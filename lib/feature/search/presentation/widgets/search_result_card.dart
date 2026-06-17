import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/search/domain/entities/search_result_entity.dart';
import 'package:rental_hub/core/widgets/app_image.dart';

class SearchResultCard extends StatelessWidget {
  final ProductItemEntity item;
  final VoidCallback onTap;

  const SearchResultCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(color: AppColors.borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(22.r),
                      ),
                      child: Container(
                        color: AppColors.surfaceVariantColor,
                        width: double.infinity,
                        child: AppNetworkImage(
                          images: item.images,
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 14.sp,
                              color: AppColors.warningColor,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              item.rating.toStringAsFixed(1),
                              style: AppStyles.labelSmall.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${item.basePricePerDay.toStringAsFixed(0)} ج.م/يوم',
                        style: AppStyles.bodyMedium.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  item.condition
                                      .toString()
                                      .toLowerCase()
                                      .contains('new')
                                  ? AppColors.successColor.withValues(
                                      alpha: 0.12,
                                    )
                                  : AppColors.primarySoftColor.withValues(
                                      alpha: 0.18,
                                    ),
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            child: Text(
                              item.condition,
                              style: AppStyles.labelSmall.copyWith(
                                color:
                                    item.condition
                                        .toString()
                                        .toLowerCase()
                                        .contains('new')
                                    ? AppColors.successColor
                                    : AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
