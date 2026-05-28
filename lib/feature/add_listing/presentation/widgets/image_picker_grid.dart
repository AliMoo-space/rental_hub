import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_hub/core/styling/app_colors.dart';

class ImagePickerGrid extends StatelessWidget {
  const ImagePickerGrid({
    required this.images,
    required this.maxImages,
    required this.onAdd,
    this.onRemove,
    super.key,
  });

  final List<XFile> images;
  final int maxImages;
  final VoidCallback onAdd;
  final ValueChanged<int>? onRemove;

  @override
  Widget build(BuildContext context) {
    final canAddMore = images.length < maxImages;
    final itemCount = canAddMore ? images.length + 1 : images.length;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        if (canAddMore && index == 0) {
          return InkWell(
            onTap: onAdd,
            borderRadius: BorderRadius.circular(18.r),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: AppColors.borderColor, width: 1),
              ),
              child: Center(
                child: Container(
                  width: 34.w,
                  height: 34.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          );
        }

        final imageIndex = canAddMore ? index - 1 : index;
        final image = images[imageIndex];

        return ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(File(image.path), fit: BoxFit.cover),
              PositionedDirectional(
                top: 6.h,
                end: 6.w,
                child: GestureDetector(
                  onTap: onRemove == null ? null : () => onRemove!(imageIndex),
                  child: Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
