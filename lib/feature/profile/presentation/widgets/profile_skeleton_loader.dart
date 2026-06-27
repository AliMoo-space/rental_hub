import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';

class ProfileSkeletonLoader extends StatefulWidget {
  const ProfileSkeletonLoader({super.key});

  @override
  State<ProfileSkeletonLoader> createState() => _ProfileSkeletonLoaderState();
}

class _ProfileSkeletonLoaderState extends State<ProfileSkeletonLoader>
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
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            _buildHeaderSkeleton(),
            SizedBox(height: 80.h),
            _buildButtonSkeleton(),
            SizedBox(height: 5.h),
            _buildButtonSkeleton(),
            SizedBox(height: 5.h),
            _buildButtonSkeleton(),
            SizedBox(height: 40.h),
            _buildSectionSkeleton(),
            SizedBox(height: 16.h),
            _buildCardSkeleton(),
            SizedBox(height: 16.h),
            _buildSectionSkeleton(),
            SizedBox(height: 16.h),
            _buildCardSkeleton(),
            SizedBox(height: 16.h),
            _buildSectionSkeleton(),
            SizedBox(height: 16.h),
            _buildCardSkeleton(),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSkeleton() {
    return Container(
      width: double.infinity,
      height: 200.h,
      color: AppColors.primaryColor.withValues(alpha: 0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 95.w,
            height: 93.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: 140.w,
            height: 16.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildButtonSkeleton() {
    return Center(
      child: Container(
        width: 260.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariantColor,
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
    );
  }

  Widget _buildSectionSkeleton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 100.w,
            height: 14.h,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariantColor,
              borderRadius: BorderRadius.circular(7.r),
            ),
          ),
          Container(
            width: 50.w,
            height: 14.h,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariantColor,
              borderRadius: BorderRadius.circular(7.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSkeleton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        width: double.infinity,
        height: 120.h,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariantColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}
