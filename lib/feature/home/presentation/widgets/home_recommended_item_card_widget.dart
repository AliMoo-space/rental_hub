import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_item_rating_widget.dart';

class HomeRecommendedItemCardWidget extends StatelessWidget {
  const HomeRecommendedItemCardWidget({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.product,
  });

  final double rating;
  final ValueChanged<double> onRatingChanged;
  final ProductEntity? product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 18.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 16.r,
            offset: Offset(0, 7.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: Stack(
          children: [
            SizedBox(width: 375.w, height: 234.h, child: _buildProductImage()),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: .55),
                    ],
                    stops: const [0.35, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12.h,
              left: 14.w,
              right: 321.w,
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: const Color(0xffFFFFFF).withValues(alpha: .8),
                child: SvgPicture.asset(AppAssets.uiHeart, width: 22.w),
              ),
            ),
            Positioned(
              bottom: 11.h,
              right: 9.w,
              left: 9.w,
              child: Container(
                width: 357.w,
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 14.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF).withValues(alpha: .8),
                  borderRadius: BorderRadiusDirectional.all(
                    Radius.circular(12.r),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppAssets.uilLocation),
                        WidthSpace(6),
                        Expanded(
                          child: Text(
                            product?.locationArea ?? 'مدينة نصر',
                            style: AppStyles.instrumentSans500Size14,
                          ),
                        ),
                        WidthSpace(8),
                        Flexible(
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: HomeItemRatingWidget(
                                rating: rating,
                                onRatingChanged: onRatingChanged,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    HeightSpace(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product?.name ?? 'كرسي ديكور',
                          style: AppStyles.instrumentSans700Size24.copyWith(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        Text(
                          '${product?.finalPricePerDay ?? 250} ج.م/اليوم',
                          style: AppStyles.instrumentSans700Size24.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    HeightSpace(10),
                    PrimaryButtonWidget(
                      width: double.infinity,
                      height: 31.h,
                      buttonText: 'عرض المنتج',
                      fontSize: 12.sp,
                      style: AppStyles.instrumentSans700Size24.copyWith(
                        fontSize: 12.sp,
                        color: const Color(0xff6A72F5),
                      ),
                      buttonColor: const Color(0xffCBCEFF),
                      bordersRadius: 20.r,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    final imagePath = product?.images.isNotEmpty == true
        ? product!.images.first
        : '';

    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(AppAssets.modernChair, fit: BoxFit.cover);
        },
      );
    }

    return Image.asset(AppAssets.modernChair, fit: BoxFit.cover);
  }
}
