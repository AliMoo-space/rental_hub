import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_shadows.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/filter_header_widget.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/deals/presentation/widgets/deals_compact_item_tile.dart';
import 'package:rental_hub/feature/wallet/presentation/widgets/balance_item_card.dart';

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
                  BalanceItemCard(
                    title: context.l10n.pendingBalance,
                    amount: "250.00 ${context.l10n.currency}",
                  ),

                  SizedBox(height: 10.h),

                  BalanceItemCard(
                    title: context.l10n.availableBalance,
                    amount: "250.00 ${context.l10n.currency}",
                  ),

                  SizedBox(height: 10.h),

                  BalanceItemCard(
                    title: context.l10n.withdrawableBalance,
                    amount: "250.00 ${context.l10n.currency}",
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
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
              child: FilterHeaderWidget(
                title: context.l10n.latestTransactions,
                selectedFilter: 'All',
                onSearchTap: () {},
                onFilterTap: () {},
              ),
            ),
            SizedBox(height: 20),

            DealsCompactItemTile(
              title: 'كاميرا (Canon)',
              subtitle: 'أدوات تصوير',
              price: '150 ج.م/اليوم',
              onTap: () {},
            ),
            DealsCompactItemTile(
              title: 'كاميرا (Canon)',
              subtitle: 'أدوات تصوير',
              price: '150 ج.م/اليوم',
              onTap: () {},
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
              child: SizedBox(
                width: double.infinity,
                child: PrimaryOutlineButtonWidget(
                  onPressed: () {},
                  text: context.l10n.viewAll,
                  textColor: AppColors.secondaryColor,
                  borderColor: AppColors.secondaryColor,
                  borderRadius: 14.r,
                  height: 42.h,
                  fontSize: 14.sp,
                ),
              ),
            ),
            HeightSpace(20),
          ],
        ),
      ),
    );
  }
}
