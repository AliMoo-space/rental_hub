import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class ChatInputBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;
  final String hintText;
  final String sendLabel;
  final bool isSending;

  const ChatInputBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSend,
    required this.hintText,
    required this.sendLabel,
    required this.isSending,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          border: Border(
            top: BorderSide(
              color: AppColors.borderColor.withValues(alpha: 0.6),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                onChanged: onChanged,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: hintText,
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(
                      color: AppColors.borderColor.withValues(alpha: 0.8),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(
                      color: AppColors.borderColor.withValues(alpha: 0.8),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.4,
                    ),
                  ),
                ),
                style: AppStyles.bodyLarge,
                onSubmitted: (_) => onSend(),
              ),
            ),
            SizedBox(width: 12.w),
            SizedBox(
              height: 48.h,
              width: 48.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isSending
                      ? AppColors.primarySoftColor
                      : AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: IconButton(
                  onPressed: isSending ? null : onSend,
                  icon: isSending
                      ? SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.whiteColor,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.send_rounded,
                          color: AppColors.whiteColor,
                        ),
                  tooltip: sendLabel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
