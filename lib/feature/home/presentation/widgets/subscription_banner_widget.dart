import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/feature/subscription/presentation/cubit/subscription_banner_cubit.dart';
import 'package:rental_hub/feature/subscription/presentation/cubit/subscription_banner_state.dart';
import 'package:rental_hub/core/utils/service_locator.dart';

class SubscriptionBannerWidget extends StatelessWidget {
  const SubscriptionBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SubscriptionBannerCubit>()..load(),
      child: BlocBuilder<SubscriptionBannerCubit, SubscriptionBannerState>(
        builder: (context, state) {
          if (state is SubscriptionBannerLoaded && state.hasActive) {
            return const SizedBox.shrink();
          }
          return Center(
            child: SizedBox(
              width: 347.w,
              height: 139.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Stack(
                  children: [
                    Image.asset(AppAssets.modernChair, fit: BoxFit.cover),
                    Image.asset(
                      AppAssets.transparent,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Positioned(
                      left: 18.w,
                      bottom: 10.h,
                      child: InkWell(
                        onTap: () => context.push(AppRoutes.subscriptionScreen),
                        child: Container(
                          margin: EdgeInsets.all(8.r),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'اشترك الآن',
                            style: AppStyles.hendi500Size20.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 24.w,
                      top: 16.h,
                      child: Column(
                        children: [
                          Text(
                            'لم تحصل على اشتراك بعد',
                            style: AppStyles.hendi500Size20.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          HeightSpace(8),
                          SizedBox(
                            width: 200.w,
                            child: Text(
                              'استمتع بمميزات خاصة عند الاشتراك',
                              style: AppStyles.instrumentSans500Size14.copyWith(
                                color: Colors.white,
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
        },
      ),
    );
  }
}
