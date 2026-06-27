import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';

class ProfileImagePicker extends StatelessWidget {
  final String? imageUrl;
  final Uint8List? localImageBytes;
  final bool isUploading;
  final VoidCallback onEditPressed;

  const ProfileImagePicker({
    super.key,
    required this.imageUrl,
    required this.localImageBytes,
    required this.isUploading,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 148.w,
        height: 148.w,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColor, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipOval(child: _buildAvatar()),
            ),
            Positioned(
              right: 6,
              bottom: 6,
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                elevation: 3,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: isUploading ? null : onEditPressed,
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: isUploading
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            Icons.camera_alt_rounded,
                            size: 18.sp,
                            color: AppColors.primaryColor,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (localImageBytes != null) {
      return Image.memory(
        localImageBytes!,
        fit: BoxFit.cover,
        width: 148.w,
        height: 148.w,
      );
    }

    if (imageUrl != null && imageUrl!.trim().isNotEmpty) {
      final isNetworkImage = Uri.tryParse(imageUrl!)?.hasScheme == true;
      if (isNetworkImage) {
        return Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          width: 148.w,
          height: 148.w,
          errorBuilder: (context, error, stackTrace) => _fallbackAvatar(),
        );
      }
    }

    return _fallbackAvatar();
  }

  Widget _fallbackAvatar() {
    return Container(
      color: AppColors.surfaceVariantColor,
      child: Image.asset(
        AppAssets.person,
        fit: BoxFit.cover,
        width: 148.w,
        height: 148.w,
      ),
    );
  }
}
