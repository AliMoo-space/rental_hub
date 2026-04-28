import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
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
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                text,
                style: AppStyles.grey12MediumStyle.copyWith(fontSize: 12.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Expanded(child: Divider(thickness: 1)),
          ],
        ),
        const HeightSpace(24),

        // Social Buttons Row
        Row(
          children: [
            Expanded(
              child: PrimaryButtonWidget(
                onPress: onFacebookPressed,
                buttonColor: Colors.grey[100],
                width: double.infinity,
                height: 41.h,
                buttonText: context.l10n.facebook,
                fontSize: 12.sp,
                icon: Padding(
                  padding: EdgeInsets.only(
                    right: isRtl ? 8.w : 0,
                    left: isRtl ? 0 : 8.w,
                  ),
                  child: SvgPicture.asset(
                    AppAssets.facebook,
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
                textColor: Colors.black,
              ),
            ),

            WidthSpace(16.w),
            Expanded(
              child: PrimaryButtonWidget(
                onPress: onGooglePressed,
                buttonColor: Colors.grey[100],
                width: double.infinity,
                height: 41.h,
                buttonText: context.l10n.google,
                fontSize: 12.sp,
                icon: Padding(
                  padding: EdgeInsets.only(
                    right: isRtl ? 8.w : 0,
                    left: isRtl ? 0 : 8.w,
                  ),
                  child: SvgPicture.asset(
                    AppAssets.google,
                    width: 20.w,
                    height: 20.h,
                  ),
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
