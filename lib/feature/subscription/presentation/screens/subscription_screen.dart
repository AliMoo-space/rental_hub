import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/feature/subscription/presentation/cubit/subscription_cubit.dart';
import 'package:rental_hub/feature/subscription/presentation/widgets/subscription_cta_button.dart';
import 'package:rental_hub/feature/subscription/presentation/widgets/subscription_feature_card.dart';
import 'package:rental_hub/feature/subscription/presentation/widgets/subscription_header_card.dart';
import 'package:rental_hub/feature/subscription/presentation/widgets/subscription_upgrade_card.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SubscriptionCubit>()..fetchSubscriptions(),
      child: BlocConsumer<SubscriptionCubit, SubscriptionState>(
        listener: (context, state) {
          if (state is SubscriptionError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading =
              state is SubscriptionInitial || state is SubscriptionLoading;
          final response = state is SubscriptionLoaded ? state.response : null;
          final plans = response?.items ?? const [];

          return Scaffold(
            backgroundColor: const Color(0xFFF8F7FF),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              foregroundColor: AppColors.textPrimaryColor,
              title: Text('خطط الاشتراك', style: AppStyles.titleMedium),
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state is SubscriptionError
                  ? _SubscriptionErrorView(
                      message: state.message,
                      onRetry: () => context
                          .read<SubscriptionCubit>()
                          .fetchSubscriptions(),
                    )
                  : SingleChildScrollView(
                      key: const ValueKey('subscription-content'),
                      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SubscriptionHeaderCard(
                            totalPlans: response?.totalCount ?? plans.length,
                            pageNumber: response?.pageNumber ?? 1,
                            totalPages: response?.totalPages ?? 1,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'اختر خطتك المثالية',
                            textAlign: TextAlign.center,
                            style: AppStyles.headlineMedium.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'استمتع بتجربة تأجير مرنة تناسب احتياجاتك، مع مزايا واضحة وتدرج بسيط في الاشتراكات.',
                            textAlign: TextAlign.center,
                            style: AppStyles.bodySmall.copyWith(
                              color: AppColors.textSecondaryColor,
                              height: 1.6,
                            ),
                          ),
                          SizedBox(height: 18.h),
                          if (plans.isEmpty)
                            _SubscriptionEmptyView(
                              onRefresh: () => context
                                  .read<SubscriptionCubit>()
                                  .fetchSubscriptions(),
                            )
                          else
                            ...plans.asMap().entries.map((entry) {
                              final index = entry.key;
                              final plan = entry.value;
                              final accentColors = [
                                AppColors.primaryColor,
                                const Color(0xff7B7AF8),
                                const Color(0xffB4A7FF),
                              ];
                              final color =
                                  accentColors[index % accentColors.length];

                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: SubscriptionFeatureCard(
                                  plan: plan,
                                  accentColor: color,
                                  buttonLabel: index == 0
                                      ? 'ابدأ الآن'
                                      : 'اشترك الآن',
                                  buttonStyle: index == 0
                                      ? SubscriptionButtonStyle.primary
                                      : index == 1
                                      ? SubscriptionButtonStyle.secondary
                                      : SubscriptionButtonStyle.ghost,
                                  isHighlighted: index == 0,
                                  onPressed: () {},
                                ),
                              );
                            }),
                          SizedBox(height: 16.h),
                          SubscriptionUpgradeCard(
                            imageAsset: AppAssets.modernChair,
                            totalPlans: response?.totalCount ?? plans.length,
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _SubscriptionEmptyView extends StatelessWidget {
  const _SubscriptionEmptyView({required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 42.sp,
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 12.h),
          Text(
            'لا توجد باقات متاحة حاليًا',
            textAlign: TextAlign.center,
            style: AppStyles.titleMedium,
          ),
          SizedBox(height: 8.h),
          Text(
            'حاول تحديث الصفحة أو أعد المحاولة بعد قليل.',
            textAlign: TextAlign.center,
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onRefresh,
              child: const Text('إعادة المحاولة'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubscriptionErrorView extends StatelessWidget {
  const _SubscriptionErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const ValueKey('subscription-error'),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 54.sp, color: AppColors.errorColor),
            SizedBox(height: 12.h),
            Text('تعذر تحميل الاشتراكات', style: AppStyles.titleMedium),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyles.bodySmall.copyWith(
                color: AppColors.textSecondaryColor,
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}
