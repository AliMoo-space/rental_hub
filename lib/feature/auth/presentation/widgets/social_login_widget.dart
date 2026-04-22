import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({
    super.key,
    required this.text,
    this.onGooglePressed,
    this.onFacebookPressed,
  });
  final String text;
  final VoidCallback? onGooglePressed;
  final VoidCallback? onFacebookPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                text,
                style: AppStyles.grey12MediumStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Expanded(child: Divider(thickness: 1)),
          ],
        ),
        const HeightSpace(30),

        Row(
          children: [
            Expanded(
              child: PrimaryButtonWidget(
                onPress: onFacebookPressed,
                buttonColor: Colors.grey[100],
                width: 161.w,
                height: 41.h,
                buttonText: 'Facebook',
                fontSize: 12.sp,
                icon: SvgPicture.asset(
                  AppAssets.facebook,
                  width: 24.w,
                  height: 24.h,
                ),
                textColor: Colors.black,
              ),
            ),

            WidthSpace(18.w),
            Expanded(
              child: PrimaryButtonWidget(
                onPress: onGooglePressed,
                buttonColor: Colors.grey[100],
                width: 161.w,

                fontSize: 12.sp,

                height: 41.h,
                buttonText: 'Google',
                icon: SvgPicture.asset(
                  AppAssets.google,
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
