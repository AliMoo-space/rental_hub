import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_deposit_method.dart';
import 'package:rental_hub/feature/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:rental_hub/feature/wallet/presentation/widgets/wallet_empty_state_card.dart';
import 'package:rental_hub/feature/wallet/presentation/widgets/wallet_transaction_tile.dart';
import 'package:rental_hub/feature/wallet/presentation/widgets/withdraw_request_tile.dart';

Future<void> showWalletDepositSheet(BuildContext walletContext) async {
  await showModalBottomSheet<void>(
    context: walletContext,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) =>
        _DepositSheetWidget(walletContext: walletContext),
  );
}

Future<void> showWalletWithdrawSheet(BuildContext walletContext) async {
  await showModalBottomSheet<void>(
    context: walletContext,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) =>
        _WithdrawSheetWidget(parentContext: walletContext),
  );
}

Future<void> showWalletHistorySheet(
  BuildContext context, {
  required WalletState state,
  required String currency,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return DraggableScrollableSheet(
        initialChildSize: 0.82,
        minChildSize: 0.62,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  Container(
                    width: 48.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    context.l10n.latestTransactions,
                    style: AppStyles.hendi500Size20.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const TabBar(
                    tabs: [
                      Tab(text: 'Transactions'),
                      Tab(text: 'Withdraws'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView(
                          controller: scrollController,
                          padding: EdgeInsets.all(18.w),
                          children: state.transactions.isEmpty
                              ? const [
                                  WalletEmptyStateCard(
                                    title: 'No transactions yet',
                                    subtitle:
                                        'Your latest wallet activity will appear here.',
                                  ),
                                ]
                              : state.transactions
                                    .map(
                                      (transaction) => Padding(
                                        padding: EdgeInsets.only(bottom: 10.h),
                                        child: WalletTransactionTile(
                                          transaction: transaction,
                                          currency: currency,
                                        ),
                                      ),
                                    )
                                    .toList(),
                        ),
                        ListView(
                          controller: scrollController,
                          padding: EdgeInsets.all(18.w),
                          children: state.withdrawRequests.isEmpty
                              ? const [
                                  WalletEmptyStateCard(
                                    title: 'No withdraw requests yet',
                                    subtitle:
                                        'Submitted withdrawal requests will show up here.',
                                  ),
                                ]
                              : state.withdrawRequests
                                    .map(
                                      (request) => Padding(
                                        padding: EdgeInsets.only(bottom: 10.h),
                                        child: WithdrawRequestTile(
                                          request: request,
                                          currency: currency,
                                        ),
                                      ),
                                    )
                                    .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

enum RechargeMethod { card, cash, instant }

class _DepositSheetWidget extends StatefulWidget {
  final BuildContext walletContext;

  const _DepositSheetWidget({required this.walletContext});

  @override
  State<_DepositSheetWidget> createState() => _DepositSheetWidgetState();
}

class _DepositSheetWidgetState extends State<_DepositSheetWidget>
    with TickerProviderStateMixin {
  final amountController = TextEditingController();
  final phoneController = TextEditingController();
  final cardTokenController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final amountFieldKey = GlobalKey<FormFieldState<String>>();

  RechargeMethod selectedMethod = RechargeMethod.card;
  int step = 1;
  bool showDetails = false;

  @override
  void dispose() {
    amountController.dispose();
    phoneController.dispose();
    cardTokenController.dispose();
    super.dispose();
  }

  void _refreshState({bool? newShowDetails, int? newStep}) {
    setState(() {
      if (newShowDetails != null) showDetails = newShowDetails;
      if (newStep != null) step = newStep;
    });
  }

  String _currentTitle(BuildContext context) {
    return showDetails
        ? _methodTitle(selectedMethod)
        : context.l10n.rechargeBalance;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 220),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (showDetails) {
                            _refreshState(newShowDetails: false, newStep: 1);
                            return;
                          }
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close_rounded),
                      ),
                      Expanded(
                        child: Text(
                          _currentTitle(context),
                          textAlign: TextAlign.right,
                          style: AppStyles.hendi500Size20.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: AppColors.borderColor, height: 20.h),
                  _rechargeStepper(step),
                  SizedBox(height: 18.h),
                  if (!showDetails) ...[
                    Text(
                      context.l10n.rechargeBalance,
                      textAlign: TextAlign.right,
                      style: AppStyles.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    _methodCards(selectedMethod, (method) {
                      _refreshState();
                      setState(() {
                        selectedMethod = method;
                      });
                    }),
                    SizedBox(height: 18.h),
                    _WalletTextField(
                      fieldKey: amountFieldKey,
                      controller: amountController,
                      label: 'المبلغ المراد شحنه (ج.م)',
                      hintText: 'مثال: 500',
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (value) {
                        final parsed = double.tryParse((value ?? '').trim());
                        if (parsed == null || parsed <= 0) {
                          return 'أدخل مبلغ صحيح';
                        }
                        return null;
                      },
                    ),
                  ] else ...[
                    Text(
                      _detailsHint(selectedMethod),
                      textAlign: TextAlign.right,
                      style: AppStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _WalletTextField(
                      key: amountFieldKey,
                      controller: amountController,
                      label: 'المبلغ المراد شحنه (ج.م)',
                      hintText: 'مثال: 500',
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (value) {
                        final parsed = double.tryParse((value ?? '').trim());
                        if (parsed == null || parsed <= 0) {
                          return 'أدخل مبلغ صحيح';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12.h),
                    _WalletTextField(
                      controller: phoneController,
                      label: _detailsFieldLabel(selectedMethod),
                      hintText: 'أدخل البيانات المطلوبة',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if ((value ?? '').trim().isEmpty) {
                          return 'هذا الحقل مطلوب';
                        }
                        return null;
                      },
                    ),
                    if (selectedMethod == RechargeMethod.card) ...[
                      SizedBox(height: 12.h),
                      _WalletTextField(
                        controller: cardTokenController,
                        label: 'Card Token',
                        hintText: 'أدخل Card Token',
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return 'هذا الحقل مطلوب';
                          }
                          return null;
                        },
                      ),
                    ],
                  ],
                  SizedBox(height: 22.h),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryOutlineButtonWidget(
                          onPressed: () {
                            if (showDetails) {
                              _refreshState(newShowDetails: false, newStep: 1);
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                          text: showDetails ? 'رجوع' : 'إلغاء',
                          textColor: AppColors.textPrimary,
                          borderColor: AppColors.borderColor,
                          borderRadius: 16.r,
                          height: 48.h,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: PrimaryButtonWidget(
                          width: double.infinity,
                          bordersRadius: 16.r,
                          height: 48.h,
                          buttonText: showDetails ? 'شحن الآن' : 'متابعة',
                          onPress: () {
                            final amountValid =
                                amountFieldKey.currentState?.validate() ??
                                false;

                            if (!showDetails) {
                              if (!amountValid) return;
                              _refreshState(newShowDetails: true, newStep: 2);
                              return;
                            }

                            final detailsValid =
                                formKey.currentState?.validate() ?? false;
                            if (!detailsValid) return;

                            Navigator.of(context).pop();
                            final trimmedPhone = phoneController.text.trim();
                            final trimmedCardToken = cardTokenController.text
                                .trim();
                            widget.walletContext.read<WalletCubit>().deposit(
                              amount: double.parse(
                                amountController.text.trim(),
                              ),
                              method: _mapDepositMethod(selectedMethod),
                              phoneNumber: trimmedPhone.isEmpty
                                  ? null
                                  : trimmedPhone,
                              cardToken: trimmedCardToken.isEmpty
                                  ? null
                                  : trimmedCardToken,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _methodCards(
    RechargeMethod selectedMethod,
    void Function(RechargeMethod method) onSelected,
  ) {
    final cards = <_RechargeMethodCardData>[
      _RechargeMethodCardData(
        method: RechargeMethod.card,
        title: 'بطاقة بنكية',
        icon: Icons.credit_card_rounded,
        iconColor: const Color(0xFF2B79FF),
      ),
      _RechargeMethodCardData(
        method: RechargeMethod.cash,
        title: 'فودافون كاش',
        icon: Icons.phone_iphone_rounded,
        iconColor: const Color(0xFFFF3B3B),
      ),
      _RechargeMethodCardData(
        method: RechargeMethod.instant,
        title: 'إستناي',
        icon: Icons.flash_on_rounded,
        iconColor: const Color(0xFF8A2BE2),
      ),
    ];

    return Row(
      children: cards
          .map(
            (card) => Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  end: card == cards.last ? 0 : 10.w,
                ),
                child: GestureDetector(
                  onTap: () => onSelected(card.method),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                        color: selectedMethod == card.method
                            ? AppColors.primaryColor
                            : AppColors.borderColor,
                        width: selectedMethod == card.method ? 1.4 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: selectedMethod == card.method
                              ? AppColors.primaryColor.withValues(alpha: 0.06)
                              : Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 56.w,
                          height: 56.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F3F8),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            card.icon,
                            color: card.iconColor,
                            size: 28.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          card.title,
                          textAlign: TextAlign.center,
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  String _methodTitle(RechargeMethod method) {
    switch (method) {
      case RechargeMethod.card:
        return 'شحن الرصيد';
      case RechargeMethod.cash:
        return 'إدخال بيانات: فودافون كاش';
      case RechargeMethod.instant:
        return 'إدخال بيانات: إنستاباي';
    }
  }

  WalletDepositMethod _mapDepositMethod(RechargeMethod method) {
    switch (method) {
      case RechargeMethod.card:
        return WalletDepositMethod.card;
      case RechargeMethod.cash:
        return WalletDepositMethod.cash;
      case RechargeMethod.instant:
        return WalletDepositMethod.instant;
    }
  }

  String _detailsHint(RechargeMethod method) {
    switch (method) {
      case RechargeMethod.card:
        return 'أدخل رقم الهاتف و Card Token لإتمام الشحن';
      case RechargeMethod.cash:
        return 'أدخل رقم الهاتف المحمول المرتبط بمحفظة فودافون كاش';
      case RechargeMethod.instant:
        return 'أدخل عنوان الدفع في إنستاباي';
    }
  }

  String _detailsFieldLabel(RechargeMethod method) {
    switch (method) {
      case RechargeMethod.card:
        return 'رقم الهاتف';
      case RechargeMethod.cash:
        return 'رقم الهاتف (Vodafone Cash)';
      case RechargeMethod.instant:
        return 'عنوان الدفع (InstaPay Address)';
    }
  }

  Widget _buildStepCircle({required String number, required bool active}) {
    return Container(
      width: 38.w,
      height: 38.w,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF7D6DEB) : const Color(0xFFE9E9EE),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        number,
        style: AppStyles.bodyMedium.copyWith(
          color: active ? AppColors.whiteColor : AppColors.textSecondary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _stepLine({required bool active}) {
    return Container(
      width: 94.w,
      height: 6.h,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF7D6DEB) : const Color(0xFFE9E9EE),
        borderRadius: BorderRadius.circular(999.r),
      ),
    );
  }

  Widget _rechargeStepper(int step) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepCircle(number: '1', active: step >= 1),
        SizedBox(width: 10.w),
        _stepLine(active: step >= 2),
        SizedBox(width: 10.w),
        _buildStepCircle(number: '2', active: step >= 2),
        SizedBox(width: 10.w),
        _stepLine(active: false),
        SizedBox(width: 10.w),
        _buildStepCircle(number: '3', active: false),
      ],
    );
  }
}

class _WithdrawSheetWidget extends StatefulWidget {
  final BuildContext parentContext;

  const _WithdrawSheetWidget({required this.parentContext});

  @override
  State<_WithdrawSheetWidget> createState() => _WithdrawSheetWidgetState();
}

class _WithdrawSheetWidgetState extends State<_WithdrawSheetWidget> {
  final amountController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    amountController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 48.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                context.l10n.withdrawBalance,
                style: AppStyles.hendi500Size20.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 16.h),
              _WalletTextField(
                controller: amountController,
                label: 'Amount',
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (_) => formKey.currentState?.validate(),
                validator: (value) {
                  final parsed = double.tryParse((value ?? '').trim());
                  if (parsed == null || parsed <= 0) {
                    return 'Enter a valid amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              _WalletTextField(
                controller: phoneController,
                label: 'Phone number',
                keyboardType: TextInputType.phone,
                onChanged: (_) => formKey.currentState?.validate(),
                validator: (value) {
                  if ((value ?? '').trim().isEmpty) {
                    return 'Phone number is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              PrimaryButtonWidget(
                width: double.infinity,
                bordersRadius: 16.r,
                height: 48.h,
                buttonText: context.l10n.save,
                onPress: () {
                  if (!formKey.currentState!.validate()) return;
                  Navigator.of(context).pop();
                  widget.parentContext.read<WalletCubit>().requestWithdraw(
                    amount: double.parse(amountController.text.trim()),
                    phoneNumber: phoneController.text.trim(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalletTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? hintText;
  final Key? fieldKey;

  const _WalletTextField({
    super.key,
    this.fieldKey,
    required this.controller,
    required this.label,
    required this.validator,
    this.keyboardType,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        filled: true,
        fillColor: AppColors.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 1.2),
        ),
      ),
    );
  }
}

class _RechargeMethodCardData {
  final RechargeMethod method;
  final String title;
  final IconData icon;
  final Color iconColor;

  _RechargeMethodCardData({
    required this.method,
    required this.title,
    required this.icon,
    required this.iconColor,
  });
}
