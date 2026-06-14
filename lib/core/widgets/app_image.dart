import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:rental_hub/core/styling/app_colors.dart';

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

class AppNetworkImage extends StatefulWidget {
  final List<String>? images;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AppNetworkImage({
    super.key,
    this.images,
    this.width,
    this.height,
    this.fit,
  });

  @override
  State<AppNetworkImage> createState() => _AppNetworkImageState();
}

class _AppNetworkImageState extends State<AppNetworkImage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final validImages = widget.images?.where((img) => img.trim().isNotEmpty).toList() ?? [];

    if (validImages.isEmpty) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 36.sp,
            color: Colors.grey,
          ),
        ),
      );
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          CarouselSlider(
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 1.0,
            enableInfiniteScroll: validImages.length > 1,
            autoPlay: validImages.length > 1,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: validImages.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return SizedBox(
                  width: widget.width ?? MediaQuery.of(context).size.width,
                  height: widget.height,
                  child: Image.network(
                    imageUrl,
                    fit: widget.fit ?? BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                        color: Colors.grey,
                        size: 36.sp,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        if (validImages.length > 1)
          Positioned(
            bottom: 8.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: validImages.asMap().entries.map((entry) {
                return Container(
                  width: _currentIndex == entry.key ? 16.w : 6.w,
                  height: 6.h,
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.r),
                    color: _currentIndex == entry.key
                        ? AppColors.primaryColor
                        : Colors.white.withValues(alpha: 0.6),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    ),
    );
  }
}
