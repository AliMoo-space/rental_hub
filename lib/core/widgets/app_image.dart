import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:rental_hub/core/styling/app_assets.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.color,
    this.isCircle = false,
  });
  final String imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Color? color;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        Widget child;
        if (imageUrl.toLowerCase().endsWith('svg')) {
          child = SvgPicture.asset(
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.error_outline, color: Colors.red),
            'assets/icons/$imageUrl',
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
          );
        } else if (imageUrl.startsWith('http')) {
          child = Image.network(
            imageUrl,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                Image.asset('assets/images/not_found.jpg', fit: BoxFit.cover),
          );
        } else if (imageUrl.toLowerCase().endsWith('json')) {
          child = LottieBuilder.asset(
            'assets/lotties/$imageUrl',
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                Image.asset('assets/images/not_found.jpg', fit: BoxFit.cover),
          );
        } else {
          child = Image.asset(
            'assets/images/$imageUrl',
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                Center(child: Icon(Icons.error)),
          );
        }
        if (isCircle) return ClipOval(child: child);
        return child;
      },
    );
  }
}

class AppNetworkImage extends StatelessWidget {
  final List<String> images;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AppNetworkImage({
    super.key,
    required this.images,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Image.asset(AppAssets.modernChair);
    }

    return AppImage(
      imageUrl: images.first,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
