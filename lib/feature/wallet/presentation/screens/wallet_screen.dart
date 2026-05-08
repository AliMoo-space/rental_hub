import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_shadows.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.wallet, style: AppStyles.hendi500Size20),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 340.w,
              height: 414.h,
              decoration: BoxDecoration(
                color: AppColors.primaryDarkColor,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [AppShadows.softCard],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.l10n.totalBalance,
                          style: AppStyles.hendi500Size20.copyWith(
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "250.00 ${context.l10n.currency}",
                          style: AppStyles.instrumentSans700Size24.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 300.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          context.l10n.pendingBalance,
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "250.00 ${context.l10n.currency}",
                          style: AppStyles.instrumentSans700Size18.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),
                  Container(
                    width: 300.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          context.l10n.availableBalance,
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "250.00 ${context.l10n.currency}",
                          style: AppStyles.instrumentSans700Size18.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),
                  Container(
                    width: 300.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          context.l10n.withdrawableBalance,
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "250.00 ${context.l10n.currency}",
                          style: AppStyles.instrumentSans700Size18.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PrimaryButtonWidget(
                        width: 140.w,
                        height: 40.h,
                        buttonText: context.l10n.withdrawBalance,
                        onPress: () {
                          // Navigate to withdraw screen
                        },
                      ),
                      PrimaryOutlineButtonWidget(
                        borderRadius: 30.r,
                        width: 140.w,
                        height: 40.h,
                        borderColor: AppColors.primaryColor,
                        textColor: AppColors.primaryColor,
                        text: context.l10n.rechargeBalance,
                        onPressed: () {
                          // Navigate to recharge screen
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: Text(
                context.l10n.activeRentals,
                style: AppStyles.hendi500Size20,
              ),
              onTap: () {
                // Navigate to transaction history screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: Text(
                context.l10n.activeRentals,
                style: AppStyles.hendi500Size20,
              ),
              onTap: () {
                // Navigate to add funds screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
