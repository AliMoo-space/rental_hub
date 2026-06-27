import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class OrderTimelineWidget extends StatelessWidget {
  final List<OrderTimelineStep> steps;

  const OrderTimelineWidget({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.orderStatusTimeline,
          style: AppStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700),
        ),
        HeightSpace(16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: steps.length,
          separatorBuilder: (_, __) => HeightSpace(0),
          itemBuilder: (context, index) {
            final step = steps[index];
            final isLast = index == steps.length - 1;
            return _TimelineItem(step: step, isLast: isLast);
          },
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final OrderTimelineStep step;
  final bool isLast;

  const _TimelineItem({required this.step, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: step.isCompleted
                    ? step.color
                    : AppColors.surfaceVariantColor,
                border: Border.all(
                  color: step.isCompleted ? step.color : AppColors.borderColor,
                  width: 2,
                ),
              ),
              child: step.isCompleted
                  ? Icon(Icons.check, color: AppColors.whiteColor, size: 14.w)
                  : Center(
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: step.isActive
                              ? step.color
                              : AppColors.textMutedColor,
                        ),
                      ),
                    ),
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: 60.h,
                color: step.isCompleted ? step.color : AppColors.borderColor,
                margin: EdgeInsets.only(top: 4.h),
              ),
          ],
        ),
        WidthSpace(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: AppStyles.bodyMedium.copyWith(
                  fontWeight: step.isActive ? FontWeight.w700 : FontWeight.w500,
                  color: step.isActive
                      ? step.color
                      : AppColors.textPrimaryColor,
                ),
              ),
              if (step.subtitle != null) ...[
                HeightSpace(2),
                Text(
                  step.subtitle!,
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
              if (step.timestamp != null) ...[
                HeightSpace(2),
                Text(
                  step.timestamp!,
                  style: AppStyles.labelSmall.copyWith(
                    color: AppColors.textMutedColor,
                    fontSize: 10.sp,
                  ),
                ),
              ],
              HeightSpace(12),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderTimelineStep {
  final String title;
  final String? subtitle;
  final String? timestamp;
  final bool isCompleted;
  final bool isActive;
  final Color color;

  const OrderTimelineStep({
    required this.title,
    this.subtitle,
    this.timestamp,
    required this.isCompleted,
    required this.isActive,
    required this.color,
  });

  static List<OrderTimelineStep> fromOrderStatus(
    String status,
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final now = DateTime.now();
    final steps = <OrderTimelineStep>[];

    // Step 1: Order Placed
    steps.add(
      OrderTimelineStep(
        title: l10n.orderPlaced,
        subtitle: l10n.orderPlacedDesc,
        timestamp: _formatDate(now.subtract(const Duration(days: 2))),
        isCompleted: true,
        isActive: false,
        color: AppColors.primaryColor,
      ),
    );

    // Step 2: Pending Approval
    final isPending = status.toLowerCase() == 'pending';
    steps.add(
      OrderTimelineStep(
        title: l10n.pendingApproval,
        subtitle: l10n.pendingApprovalDesc,
        timestamp: _formatDate(now.subtract(const Duration(days: 1))),
        isCompleted: !isPending,
        isActive: isPending,
        color: AppColors.warningColor,
      ),
    );

    // Step 3: Approved
    final isApproved = [
      'approved',
      'shipped',
      'confirmed receipt',
      'confirmed',
      'delivered',
      'returned',
    ].contains(status.toLowerCase());
    final isShipped = status.toLowerCase() == 'shipped';
    steps.add(
      OrderTimelineStep(
        title: l10n.orderApproved,
        subtitle: l10n.orderApprovedDesc,
        timestamp: isApproved || isShipped ? _formatDate(now) : null,
        isCompleted: isApproved || isShipped,
        isActive: isApproved && !isShipped,
        color: AppColors.primaryColor,
      ),
    );

    // Step 4: Shipped
    if (isShipped ||
        [
          'confirmed receipt',
          'confirmed',
          'delivered',
          'returned',
        ].contains(status.toLowerCase())) {
      steps.add(
        OrderTimelineStep(
          title: l10n.orderShipped,
          subtitle: l10n.orderShippedDesc,
          timestamp: _formatDate(now),
          isCompleted: true,
          isActive: isShipped,
          color: AppColors.primaryColor,
        ),
      );
    }

    // Step 5: Confirmed Receipt
    final isConfirmed = [
      'confirmed receipt',
      'confirmed',
      'delivered',
      'returned',
    ].contains(status.toLowerCase());
    if (isConfirmed) {
      steps.add(
        OrderTimelineStep(
          title: l10n.confirmedReceipt,
          subtitle: l10n.confirmedReceiptDesc,
          timestamp: _formatDate(now),
          isCompleted: true,
          isActive: false,
          color: AppColors.successColor,
        ),
      );
    }

    // Step 6: Returned (if applicable)
    if (status.toLowerCase() == 'returned') {
      steps.add(
        OrderTimelineStep(
          title: l10n.orderReturned,
          subtitle: l10n.orderReturnedDesc,
          timestamp: _formatDate(now),
          isCompleted: true,
          isActive: false,
          color: AppColors.textMutedColor,
        ),
      );
    }

    return steps;
  }

  static String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
