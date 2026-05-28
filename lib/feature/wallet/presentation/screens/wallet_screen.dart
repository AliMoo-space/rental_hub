import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
import 'package:rental_hub/core/widgets/filter_header_widget.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:rental_hub/feature/wallet/presentation/widgets/wallet_action_sheets.dart';
import 'package:rental_hub/feature/wallet/presentation/widgets/wallet_card_preview.dart';
import 'package:rental_hub/feature/wallet/presentation/widgets/wallet_empty_state_card.dart';
import 'package:rental_hub/feature/wallet/presentation/widgets/wallet_loading_overlay.dart';
import 'package:rental_hub/feature/wallet/presentation/widgets/wallet_promo_banner.dart';
import 'package:rental_hub/feature/wallet/presentation/widgets/wallet_summary_card.dart';
import 'package:rental_hub/feature/wallet/presentation/widgets/wallet_transaction_tile.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<WalletCubit>().loadWallet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          showMsg(state.errorMessage!, context, isError: true);
          context.read<WalletCubit>().clearFeedback();
        }
        if (state.actionMessage != null) {
          showMsg(state.actionMessage!, context);
          context.read<WalletCubit>().clearFeedback();
        }
      },
      builder: (context, state) {
        final currency = _currencyLabel(context, state);

        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.wallet, style: AppStyles.hendi500Size20),
          ),
          body: Stack(
            children: [
              RefreshIndicator(
                onRefresh: () => context.read<WalletCubit>().loadWallet(),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 24.h),
                  children: [
                    WalletSummaryCard(
                      balance: state.balance?.balance ?? 0,
                      currency: currency,
                      onWithdrawPressed: () => showWalletWithdrawSheet(context),
                      onRechargePressed: () => showWalletDepositSheet(context),
                    ),
                    SizedBox(height: 18.h),
                    const WalletCardPreview(),
                    SizedBox(height: 18.h),
                    const WalletPromoBanner(),
                    SizedBox(height: 20.h),
                    SizedBox(height: 22.h),
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 2.w),
                      child: FilterHeaderWidget(
                        title: context.l10n.latestTransactions,
                        selectedFilter: 'All',
                        onSearchTap: () =>
                            context.read<WalletCubit>().loadWallet(),
                        onFilterTap: () => showWalletHistorySheet(
                          context,
                          state: state,
                          currency: currency,
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    if (state.transactions.isEmpty)
                      const WalletEmptyStateCard(
                        title: 'No transactions yet',
                        subtitle:
                            'Your latest wallet activity will appear here.',
                      )
                    else
                      ...state.transactions
                          .take(3)
                          .map(
                            (transaction) => Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: WalletTransactionTile(
                                transaction: transaction,
                                currency: currency,
                              ),
                            ),
                          ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryOutlineButtonWidget(
                        onPressed: () => showWalletHistorySheet(
                          context,
                          state: state,
                          currency: currency,
                        ),
                        text: context.l10n.viewAll,
                        textColor: AppColors.secondaryColor,
                        borderColor: AppColors.secondaryColor,
                        borderRadius: 14.r,
                        height: 42.h,
                        fontSize: 14.sp,
                      ),
                    ),
                    HeightSpace(20),
                  ],
                ),
              ),
              if (state.isLoading || state.isSubmitting)
                WalletLoadingOverlay(
                  message: state.isSubmitting
                      ? 'Processing...'
                      : 'Loading wallet...',
                ),
            ],
          ),
        );
      },
    );
  }

  String _currencyLabel(BuildContext context, WalletState state) {
    final apiCurrency = state.balance?.currency.trim();
    return (apiCurrency != null && apiCurrency.isNotEmpty)
        ? apiCurrency
        : context.l10n.currency;
  }
}
