import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';

class HomeItemRatingWidget extends StatelessWidget {
  const HomeItemRatingWidget({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  final double rating;
  final ValueChanged<double> onRatingChanged;

  @override
  Widget build(BuildContext context) {
    const totalStars = 5;
    final fullStars = rating.floor();
    final hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalStars, (starIndex) {
        final isFull = starIndex < fullStars;
        final isHalf = starIndex == fullStars && hasHalfStar;

        IconData icon;
        if (isFull) {
          icon = Icons.star_rounded;
        } else if (isHalf) {
          icon = Icons.star_half_rounded;
        } else {
          icon = Icons.star_outline_rounded;
        }

        return Padding(
          padding: EdgeInsetsDirectional.only(start: starIndex == 0 ? 0 : 4.w),
          child: InkResponse(
            onTap: () => onRatingChanged(starIndex + 1.0),
            radius: 14.r,
            splashColor: const Color(0xffF7B500).withValues(alpha: 0.2),
            highlightColor: Colors.transparent,
            child: Icon(
              icon,
              size: 18.sp,
              color: (isFull || isHalf)
                  ? const Color(0xffF7B500)
                  : AppColors.secondaryColor,
            ),
          ),
        );
      }),
    );
  }
}
