import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';

class StarSelectorWidget extends StatelessWidget {
  final double rating;
  final bool readOnly;
  final ValueChanged<int>? onChanged;

  const StarSelectorWidget({
    super.key,
    required this.rating,
    this.readOnly = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          final starValue = index + 1;
          final icon = _resolveIcon(starValue);

          return Padding(
            padding: EdgeInsetsDirectional.only(end: 4.w),
            child: InkResponse(
              onTap: readOnly ? null : () => onChanged?.call(starValue),
              radius: 20.r,
              child: Icon(icon, color: AppColors.primaryColor, size: 22.sp),
            ),
          );
        }),
      ),
    );
  }

  IconData _resolveIcon(int starValue) {
    if (rating >= starValue) {
      return Icons.star_rounded;
    }
    if (rating >= starValue - 0.5) {
      return Icons.star_half_rounded;
    }
    return Icons.star_border_rounded;
  }
}
