import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/chat/domain/entities/conversation_entity.dart';

class ConversationTileWidget extends StatelessWidget {
  final ConversationEntity conversation;
  final VoidCallback onTap;

  const ConversationTileWidget({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final timeLabel = conversation.lastMessageAt == null
        ? ''
        : DateFormat('hh:mm a').format(conversation.lastMessageAt!.toLocal());

    return Material(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(18.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: AppColors.primarySoftColor,
                backgroundImage: conversation.sellerAvatar.isNotEmpty
                    ? CachedNetworkImageProvider(conversation.sellerAvatar)
                    : null,
                child: conversation.sellerAvatar.isEmpty
                    ? Text(
                        conversation.sellerName.isNotEmpty
                            ? conversation.sellerName[0].toUpperCase()
                            : '?',
                        style: AppStyles.bodyLarge.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation.sellerName.isNotEmpty
                                ? conversation.sellerName
                                : conversation.productName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.bodyLarge.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (timeLabel.isNotEmpty)
                          Text(timeLabel, style: AppStyles.bodySmall),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      conversation.lastMessage.isNotEmpty
                          ? conversation.lastMessage
                          : conversation.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (conversation.unreadCount > 0)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            child: Text(
                              conversation.unreadCount.toString(),
                              style: AppStyles.bodySmall.copyWith(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
