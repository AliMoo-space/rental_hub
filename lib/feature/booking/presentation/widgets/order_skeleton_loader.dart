import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class OrderSkeletonLoader extends StatefulWidget {
  const OrderSkeletonLoader({super.key});

  @override
  State<OrderSkeletonLoader> createState() => _OrderSkeletonLoaderState();
}

class _OrderSkeletonLoaderState extends State<OrderSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.3, end: 0.7).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) =>
          Opacity(opacity: _opacity.value, child: child),
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        itemCount: 5,
        separatorBuilder: (_, __) => HeightSpace(12),
        itemBuilder: (context, index) => _buildCardSkeleton(),
      ),
    );
  }

  Widget _buildCardSkeleton() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariantColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          WidthSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 140.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                ),
                HeightSpace(8),
                Container(
                  width: 70.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                HeightSpace(8),
                Container(
                  width: double.infinity,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                HeightSpace(6),
                Container(
                  width: 100.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                HeightSpace(10),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    width: 90.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
