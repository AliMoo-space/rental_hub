import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';
import 'package:rental_hub/feature/wallet/presentation/widgets/balance_item_card.dart';

class WalletSummaryCard extends StatelessWidget {
  final double balance;
  final String currency;
  final VoidCallback onWithdrawPressed;
  final VoidCallback onRechargePressed;

  const WalletSummaryCard({
    super.key,
    required this.balance,
    required this.currency,
    required this.onWithdrawPressed,
    required this.onRechargePressed,
  });

  String _formatAmount(double amount) =>
      '${amount.toStringAsFixed(2)} $currency';

  @override
  Widget build(BuildContext context) {
    final pending = balance * 0.10;
    final available = balance * 0.45;
    final withdrawable = balance * 0.45;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE4E2FF),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              children: [
                Text(
                  context.l10n.totalBalance,
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  _formatAmount(balance),
                  style: AppStyles.instrumentSans700Size24.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 30.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          BalanceItemCard(
            title: context.l10n.pendingBalance,
            amount: _formatAmount(pending),
          ),
          SizedBox(height: 8.h),
          BalanceItemCard(
            title: context.l10n.availableBalance,
            amount: _formatAmount(available),
          ),
          SizedBox(height: 8.h),
          BalanceItemCard(
            title: context.l10n.withdrawableBalance,
            amount: _formatAmount(withdrawable),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: PrimaryButtonWidget(
                  width: double.infinity,
                  height: 38.h,
                  bordersRadius: 14.r,
                  buttonText: context.l10n.rechargeBalance,
                  onPress: onRechargePressed,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: PrimaryOutlineButtonWidget(
                  onPressed: onWithdrawPressed,
                  text: context.l10n.withdrawBalance,
                  textColor: AppColors.primaryColor,
                  borderColor: AppColors.primaryColor,
                  borderRadius: 14.r,
                  height: 38.h,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
