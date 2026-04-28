import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/custom_text_field.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class HomeSearchSectionWidget extends StatelessWidget {
  const HomeSearchSectionWidget({
    super.key,
    required this.title,
    required this.searchHint,
  });

  final String title;
  final String searchHint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            title,
            style: AppStyles.intro32semiBold.copyWith(fontSize: 20.sp),
          ),
        ),
        HeightSpace(9),
        CustomTextField(
          width: 364.w,
          hintText: searchHint,
          suffixIcon: Icon(
            Icons.search_rounded,
            size: 33.sp,
            color: AppColors.secondaryColor,
          ),
        ),
      ],
    );
  }
}
