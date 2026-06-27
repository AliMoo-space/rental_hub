import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/booking_action_cubit.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/order_action_bottom_sheet.dart';

class OrderActionButtons extends StatelessWidget {
  final RentalOrderEntity order;
  final String currentUserId;
  final VoidCallback? onActionSuccess;

  const OrderActionButtons({
    super.key,
    required this.order,
    required this.currentUserId,
    this.onActionSuccess,
  });

  bool get _isOwner => currentUserId == order.ownerId;
  bool get _isRenter => currentUserId == order.renterId;

  @override
  Widget build(BuildContext context) {
    final buttons = _buildButtonConfigs(context);
    if (buttons.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(height: 1.h, color: AppColors.borderColor),
        HeightSpace(16),
        Text(
          context.l10n.quickActions,
          style: AppStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700),
        ),
        HeightSpace(12),
        ...buttons.map(
          (config) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: SizedBox(
              width: double.infinity,
              height: 48.h,
              child: PrimaryButtonWidget(
                buttonText: config.label,
                buttonColor: config.color,
                textColor: config.textColor,
                bordersRadius: 12.r,
                onPress: () => _handleAction(
                  context,
                  config.action,
                  config.requiresReason,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<_ButtonConfig> _buildButtonConfigs(BuildContext context) {
    final status = order.status.toLowerCase();
    final configs = <_ButtonConfig>[];

    if (_isOwner) {
      switch (status) {
        case 'pending':
          configs.add(
            _ButtonConfig(
              label: context.l10n.approveOrderLabel,
              action: _Action.approve,
              color: AppColors.successColor,
              textColor: AppColors.whiteColor,
            ),
          );
          configs.add(
            _ButtonConfig(
              label: context.l10n.rejectOrderLabel,
              action: _Action.reject,
              requiresReason: true,
              color: AppColors.errorColor,
              textColor: AppColors.whiteColor,
            ),
          );
        case 'approved':
          configs.add(
            _ButtonConfig(
              label: context.l10n.shipOrderLabel,
              action: _Action.ship,
              color: AppColors.primaryColor,
              textColor: AppColors.whiteColor,
            ),
          );
        default:
          break;
      }
    } else if (_isRenter) {
      switch (status) {
        case 'pending':
          configs.add(
            _ButtonConfig(
              label: context.l10n.cancelOrderLabel,
              action: _Action.cancel,
              color: AppColors.errorColor,
              textColor: AppColors.whiteColor,
            ),
          );
        case 'approved':
          configs.add(
            _ButtonConfig(
              label: context.l10n.cancelOrderLabel,
              action: _Action.cancel,
              color: AppColors.errorColor,
              textColor: AppColors.whiteColor,
            ),
          );
        case 'shipped':
          configs.add(
            _ButtonConfig(
              label: context.l10n.confirmReceiptLabel,
              action: _Action.confirmReceipt,
              color: AppColors.successColor,
              textColor: AppColors.whiteColor,
            ),
          );
        case 'confirmed receipt':
        case 'confirmed':
        case 'delivered':
          configs.add(
            _ButtonConfig(
              label: context.l10n.returnOrderLabel,
              action: _Action.returnOrder,
              requiresReason: true,
              color: AppColors.warningColor,
              textColor: AppColors.whiteColor,
            ),
          );
        default:
          break;
      }
    }

    return configs;
  }

  void _handleAction(
    BuildContext context,
    _Action action,
    bool requiresReason,
  ) {
    if (requiresReason) {
      _showReasonBottomSheet(context, action);
    } else if (action == _Action.cancel || action == _Action.returnOrder) {
      _showConfirmationBottomSheet(context, action);
    } else {
      _executeAction(context, action, null);
    }
  }

  void _showReasonBottomSheet(BuildContext context, _Action action) async {
    final title = action == _Action.reject
        ? context.l10n.rejectReasonTitle
        : context.l10n.returnReasonTitle;
    final hint = action == _Action.reject
        ? context.l10n.rejectReasonHint
        : context.l10n.returnReasonHint;
    final confirmLabel = action == _Action.reject
        ? context.l10n.rejectOrderLabel
        : context.l10n.returnOrderLabel;

    final reason = await OrderActionBottomSheet.show(
      context: context,
      title: title,
      hint: hint,
      confirmLabel: confirmLabel,
    );

    if (reason != null && reason.isNotEmpty) {
      _executeAction(context, action, reason);
    }
  }

  void _showConfirmationBottomSheet(
    BuildContext context,
    _Action action,
  ) async {
    String title, message, confirmLabel;
    Color confirmColor;

    if (action == _Action.cancel) {
      title = context.l10n.cancelOrderTitle;
      message = context.l10n.cancelOrderMessage;
      confirmLabel = context.l10n.cancelOrderLabel;
      confirmColor = AppColors.errorColor;
    } else {
      title = context.l10n.returnOrderTitle;
      message = context.l10n.returnOrderMessage;
      confirmLabel = context.l10n.returnOrderLabel;
      confirmColor = AppColors.warningColor;
    }

    final confirmed = await OrderConfirmationBottomSheet.show(
      context: context,
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      confirmColor: confirmColor,
    );

    if (confirmed) {
      _executeAction(context, action, null);
    }
  }

  void _executeAction(BuildContext context, _Action action, String? reason) {
    final cubit = context.read<BookingActionCubit>();
    switch (action) {
      case _Action.approve:
        cubit.approveOrder(order.id);
      case _Action.reject:
        cubit.rejectOrder(order.id, reason: reason);
      case _Action.cancel:
        cubit.cancelOrder(order.id);
      case _Action.ship:
        cubit.shipOrder(order.id);
      case _Action.confirmReceipt:
        cubit.confirmReceiptOrder(order.id);
      case _Action.returnOrder:
        cubit.returnOrder(order.id, reason: reason);
    }
  }
}

enum _Action { approve, reject, cancel, ship, confirmReceipt, returnOrder }

class _ButtonConfig {
  final String label;
  final _Action action;
  final bool requiresReason;
  final Color color;
  final Color textColor;

  _ButtonConfig({
    required this.label,
    required this.action,
    this.requiresReason = false,
    required this.color,
    required this.textColor,
  });
}
