import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rental_hub/core/styling/app_colors.dart';

class SearchLoadingShimmer extends StatelessWidget {
  final bool showMoreTile;

  const SearchLoadingShimmer({super.key, this.showMoreTile = false});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceVariantColor.withValues(alpha: 0.7),
      highlightColor: Colors.white,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.72,
        ),
        itemCount: 6 + (showMoreTile ? 1 : 0),
        itemBuilder: (context, index) {
          if (showMoreTile && index == 6) {
            return _ShimmerCard(loadMore: true);
          }
          return const _ShimmerCard();
        },
      ),
    );
  }
}

class SearchSuggestionsShimmer extends StatelessWidget {
  const SearchSuggestionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceVariantColor.withValues(alpha: 0.7),
      highlightColor: Colors.white,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        separatorBuilder: (context, index) =>
            Divider(height: 1.h, thickness: 1, color: AppColors.borderColor),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12.h,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8.h),
                    Container(height: 10.h, width: 160.w, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  final bool loadMore;

  const _ShimmerCard({this.loadMore = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 122.w,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariantColor,
                borderRadius: BorderRadius.circular(18.r),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              height: 14.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariantColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 12.h,
              width: 90.w,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariantColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            const Spacer(),
            if (loadMore)
              Container(
                height: 24.h,
                width: 74.w,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariantColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              )
            else
              Container(
                height: 24.h,
                width: 74.w,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariantColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
