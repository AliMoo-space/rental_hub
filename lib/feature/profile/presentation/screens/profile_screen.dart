import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/renter_stats_cubit.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/renter_stats_state.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/renter_stats_widget.dart';
import 'package:rental_hub/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:rental_hub/feature/profile/presentation/cubit/user_profile_cubit.dart';
import 'package:rental_hub/feature/profile/presentation/cubit/user_profile_state.dart';
import 'package:rental_hub/feature/profile/presentation/widgets/app_drawer.dart';
import 'package:rental_hub/feature/profile/presentation/widgets/profile_error_state.dart';
import 'package:rental_hub/feature/profile/presentation/widgets/profile_skeleton_loader.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.l10n.myProfile, style: AppStyles.hendi500Size20),
      ),
      body: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading && state.userProfile == null) {
            return const ProfileSkeletonLoader();
          }
          if (state is UserProfileError && state.userProfile == null) {
            return ProfileErrorState(
              message: state.message ?? 'Error loading profile',
              onRetry: () => context.read<UserProfileCubit>().loadProfile(),
              retryLabel: context.l10n.retryLabel,
            );
          }
          return _ProfileContent(
            profile: state.userProfile ?? const UserProfileEntity(),
          );
        },
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  final UserProfileEntity profile;

  const _ProfileContent({required this.profile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 200.h,
                color: AppColors.primaryColor,
              ),
              Positioned(
                top: 130.h,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 52.r,
                      backgroundColor: Colors.white54,
                      child: ClipOval(
                        child: profile.profileImage.isNotEmpty
                            ? Image.network(
                                profile.profileImage,
                                width: 95.w,
                                height: 93.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                      AppAssets.person,
                                      width: 95.w,
                                      height: 93.h,
                                      fit: BoxFit.cover,
                                    ),
                              )
                            : Image.asset(
                                AppAssets.person,
                                width: 95.w,
                                height: 93.h,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    HeightSpace(12),
                    Text(
                      profile.fullName.isNotEmpty
                          ? profile.fullName
                          : context.l10n.myProfile,
                      style: AppStyles.instrumentSans700Size24,
                    ),
                  ],
                ),
              ),
            ],
          ),
          HeightSpace(80),
          SizedBox(
            width: 260.w,
            child: PrimaryButtonWidget(
              buttonText: context.l10n.addListing,
              onPress: () => context.pushNamed(AppRoutes.addListingScreen),
              buttonColor: AppColors.primaryColor,
              style: AppStyles.hendi500Size20.copyWith(
                color: Colors.white,
                fontSize: 15.sp,
              ),
              width: 260.w,
              height: 44.h,
            ),
          ),
          HeightSpace(5),
          SizedBox(
            width: 260.w,
            child: PrimaryOutlineButtonWidget(
              text: context.l10n.addQuestion,
              onPressed: () => context.pushNamed(AppRoutes.communityScreen),
              textColor: AppColors.secondaryColor,
              borderRadius: 30.r,
              borderColor: AppColors.secondaryColor,
              width: 260.w,
              height: 44.h,
            ),
          ),
          HeightSpace(5),
          SizedBox(
            width: 260.w,
            child: PrimaryOutlineButtonWidget(
              text: context.l10n.editProfile,
              onPressed: () => context.pushNamed(AppRoutes.userProfileScreen),
              textColor: AppColors.secondaryColor,
              borderRadius: 30.r,
              borderColor: AppColors.secondaryColor,
              width: 260.w,
              height: 44.h,
            ),
          ),
          _SectionHeader(
            title: context.l10n.myListings,
            onViewAll: () => context.pushNamed(AppRoutes.myProductsScreen),
          ),
          HeightSpace(16),
          _PlaceholderCard(
            onTap: () => context.pushNamed(AppRoutes.myProductsScreen),
          ),
          _SectionHeader(
            title: context.l10n.myListingsOrders,
            onViewAll: () =>
                context.pushNamed(AppRoutes.myListingsOrdersScreen),
          ),
          HeightSpace(16),
          _PlaceholderCard(
            onTap: () => context.pushNamed(AppRoutes.myListingsOrdersScreen),
          ),
          _SectionHeader(
            title: context.l10n.activeRentals,
            onViewAll: () => context.pushNamed(AppRoutes.myOrdersScreen),
          ),
          HeightSpace(16),
          BlocProvider(
            create: (_) => getIt<RenterStatsCubit>()..loadStats(),
            child: BlocBuilder<RenterStatsCubit, RenterStatsState>(
              builder: (context, state) {
                if (state is RenterStatsLoading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      height: 140.h,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariantColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  );
                }
                if (state is RenterStatsFailure) {
                  return _PlaceholderCard(
                    onTap: () => context.pushNamed(AppRoutes.myOrdersScreen),
                  );
                }
                if (state is RenterStatsLoaded) {
                  return RenterStatsWidget(stats: state.stats);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          HeightSpace(32),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const _SectionHeader({required this.title, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppStyles.instrumentSans700Size18),
          if (onViewAll != null)
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                context.l10n.viewAll,
                style: AppStyles.instrumentSans500Size14.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PlaceholderCard extends StatelessWidget {
  final VoidCallback? onTap;

  const _PlaceholderCard({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),

      child: GestureDetector(
        onTap: onTap,

        child: Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Center(
            child: Icon(
              Icons.inventory_2_outlined,
              size: 36.sp,
              color: AppColors.textMutedColor,
            ),
          ),
        ),
      ),
    );
  }
}
