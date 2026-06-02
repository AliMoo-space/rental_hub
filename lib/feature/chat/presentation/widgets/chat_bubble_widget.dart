import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/chat/domain/entities/chat_message_status.dart';
import 'package:rental_hub/feature/chat/domain/entities/message_entity.dart';

class ChatBubbleWidget extends StatelessWidget {
  final MessageEntity message;

  const ChatBubbleWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMine;
    final bubbleColor = isMine ? AppColors.primaryColor : AppColors.whiteColor;
    final textColor = isMine ? AppColors.whiteColor : AppColors.textPrimary;
    final alignment = isMine ? Alignment.centerRight : Alignment.centerLeft;
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(18.r),
      topRight: Radius.circular(18.r),
      bottomLeft: Radius.circular(isMine ? 18.r : 4.r),
      bottomRight: Radius.circular(isMine ? 4.r : 18.r),
    );

    return Align(
      alignment: alignment,
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 0.78.sw),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
              border: isMine
                  ? null
                  : Border.all(
                      color: AppColors.borderColor.withValues(alpha: 0.6),
                    ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.content,
                  style: AppStyles.bodyLarge.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('hh:mm a').format(message.timestamp.toLocal()),
                      style: AppStyles.bodySmall.copyWith(
                        color: textColor.withValues(alpha: 0.75),
                      ),
                    ),
                    if (isMine) ...[
                      SizedBox(width: 6.w),
                      _StatusIcon(status: message.status),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final ChatMessageStatus status;

  const _StatusIcon({required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ChatMessageStatus.sent:
        return Icon(
          Icons.check,
          size: 16.w,
          color: AppColors.whiteColor.withValues(alpha: 0.75),
        );
      case ChatMessageStatus.delivered:
        return Icon(
          Icons.done_all,
          size: 16.w,
          color: AppColors.whiteColor.withValues(alpha: 0.85),
        );
      case ChatMessageStatus.read:
        return Icon(Icons.done_all, size: 16.w, color: const Color(0xFF59A7FF));
    }
  }
}
