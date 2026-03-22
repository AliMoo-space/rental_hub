import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(text, style: AppStyles.grey12MediumStyle),
            ),
            Expanded(child: Divider(thickness: 1)), // فاصل يمين
          ],
        ),
        HeightSpace(32),
        Row(
          children: [
            Expanded(
              child: PrimrayButtonWidget(
                onPress: () {},
                buttonColor: Colors.grey[100],
                height: 56.h,
                buttonText: 'Google',
                icon: SvgPicture.asset(
                  'assets/icons/google.svg',
                  width: 24.w,
                  height: 24.h,
                ),
                textColor: Colors.black,
              ),
            ),
            WidthSpace(18),
            Expanded(
              child: PrimrayButtonWidget(
                onPress: () {},
                buttonColor: Colors.grey[100],
                height: 56.h,
                buttonText: 'Facebook',
                icon: SvgPicture.asset(
                  AppAssets.facebook,
                  width: 24.w,
                  height: 24.h,
                ),
                textColor: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
