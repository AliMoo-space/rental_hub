import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rental_hub/core/styling/app_assets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.width, this.height});
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height,
      width: width ?? MediaQuery.of(context).size.width,
      child: Center(
        child: LottieBuilder.asset(
          AppAssets.loadingLottie,
          width: 150.w,
          height: 150.w,
        ),
      ),
    );
  }
}
