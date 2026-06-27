import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class OrderActionBottomSheet extends StatefulWidget {
  final String title;
  final String hint;
  final String confirmLabel;
  final String? initialReason;
  final Function(String reason) onConfirm;

  const OrderActionBottomSheet({
    super.key,
    required this.title,
    required this.hint,
    required this.confirmLabel,
    this.initialReason,
    required this.onConfirm,
  });

  static Future<String?> show({
    required BuildContext context,
    required String title,
    required String hint,
    required String confirmLabel,
    String? initialReason,
  }) {
    final completer = Completer<String?>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => OrderActionBottomSheet(
        title: title,
        hint: hint,
        confirmLabel: confirmLabel,
        initialReason: initialReason,
        onConfirm: (reason) => completer.complete(reason),
      ),
    );
    return completer.future;
  }

  @override
  State<OrderActionBottomSheet> createState() => _OrderActionBottomSheetState();
}

class _OrderActionBottomSheetState extends State<OrderActionBottomSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialReason);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        left: 24.w,
        right: 24.w,
        top: 24.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.borderColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          HeightSpace(24),
          Text(
            widget.title,
            style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          HeightSpace(8),
          Text(
            widget.hint,
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.textSecondaryColor,
            ),
          ),
          HeightSpace(16),
          TextField(
            controller: _controller,
            maxLines: 4,
            minLines: 3,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppStyles.bodySmall.copyWith(
                color: AppColors.textMutedColor,
              ),
              filled: true,
              fillColor: AppColors.surfaceColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
              contentPadding: EdgeInsets.all(16.w),
            ),
            style: AppStyles.bodyMedium,
          ),
          HeightSpace(24),
          Row(
            children: [
              Expanded(
                child: PrimaryButtonWidget(
                  buttonText: context.l10n.cancel,
                  buttonColor: AppColors.surfaceColor,
                  textColor: AppColors.textSecondaryColor,
                  height: 48.h,
                  onPress: () => Navigator.of(context).pop(),
                ),
              ),
              WidthSpace(12),
              Expanded(
                child: PrimaryButtonWidget(
                  buttonText: widget.confirmLabel,
                  height: 48.h,
                  onPress: () {
                    Navigator.of(context).pop();
                    widget.onConfirm(_controller.text.trim());
                  },
                ),
              ),
            ],
          ),
          HeightSpace(16),
        ],
      ),
    );
  }
}

class OrderConfirmationBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final Color confirmColor;
  final VoidCallback onConfirm;

  const OrderConfirmationBottomSheet({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.confirmColor,
    required this.onConfirm,
  });

  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmLabel,
    Color confirmColor = AppColors.errorColor,
  }) {
    final completer = Completer<bool>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => OrderConfirmationBottomSheet(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        confirmColor: confirmColor,
        onConfirm: () => completer.complete(true),
      ),
    );
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          HeightSpace(24),
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: confirmColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: confirmColor,
              size: 32.w,
            ),
          ),
          HeightSpace(16),
          Text(
            title,
            style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          HeightSpace(8),
          Text(
            message,
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          HeightSpace(24),
          Row(
            children: [
              Expanded(
                child: PrimaryButtonWidget(
                  buttonText: context.l10n.cancel,
                  buttonColor: AppColors.surfaceColor,
                  textColor: AppColors.textSecondaryColor,
                  height: 48.h,
                  onPress: () => Navigator.of(context).pop(false),
                ),
              ),
              WidthSpace(12),
              Expanded(
                child: PrimaryButtonWidget(
                  buttonText: confirmLabel,
                  buttonColor: confirmColor,
                  height: 48.h,
                  onPress: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                ),
              ),
            ],
          ),
          HeightSpace(16),
        ],
      ),
    );
  }
}
