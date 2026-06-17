import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_recommended_item_card_widget.dart';
import 'package:rental_hub/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:rental_hub/feature/profile/presentation/cubit/user_profile_cubit.dart';
import 'package:rental_hub/feature/profile/presentation/cubit/user_profile_state.dart';
import 'package:rental_hub/feature/profile/presentation/widgets/app_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<double> _ratings = List<double>.generate(6, (_) => 3.5);

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
          final profile = state.userProfile ?? const UserProfileEntity();

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
                                      errorBuilder:
                                          (context, error, stackTrace) =>
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
                                : 'User Name',
                            style: AppStyles.instrumentSans700Size24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                HeightSpace(80),
                PrimaryButtonWidget(
                  buttonText: context.l10n.addListing,
                  onPress: () {
                    context.pushNamed(AppRoutes.addListingScreen);
                  },
                  buttonColor: AppColors.primaryColor,
                  style: AppStyles.hendi500Size20.copyWith(
                    color: Colors.white,
                    fontSize: 15.sp,
                  ),
                  width: 260.w,
                  height: 44.h,
                ),
                HeightSpace(5),
                PrimaryOutlineButtonWidget(
                  text: context.l10n.addQuestion,
                  onPressed: () {
                    context.pushNamed(AppRoutes.communityScreen);
                  },
                  textColor: AppColors.secondaryColor,
                  borderRadius: 30.r,
                  borderColor: AppColors.secondaryColor,
                  width: 260.w,
                  height: 44.h,
                ),
                HeightSpace(5),
                PrimaryOutlineButtonWidget(
                  text: context.l10n.editProfile,
                  onPressed: () {
                    context.pushNamed(AppRoutes.userProfileScreen);
                  },
                  textColor: AppColors.secondaryColor,
                  borderRadius: 30.r,
                  borderColor: AppColors.secondaryColor,
                  width: 260.w,
                  height: 44.h,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.myListings,
                        style: AppStyles.instrumentSans700Size18,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.myProductsScreen);
                        },
                        child: Text(
                          context.l10n.viewAll,
                          style: AppStyles.instrumentSans500Size14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'طلبات الإيجار لمنتجاتي',
                        style: AppStyles.instrumentSans700Size18,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.myListingsOrdersScreen);
                        },
                        child: Text(
                          context.l10n.viewAll,
                          style: AppStyles.instrumentSans500Size14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                HomeRecommendedItemCardWidget(
                  rating: _ratings[0],
                  onRatingChanged: (newRating) {
                    setState(() {
                      _ratings[0] = newRating;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.activeRentals,
                        style: AppStyles.instrumentSans700Size18,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.myOrdersScreen);
                        },
                        child: Text(
                          context.l10n.viewAll,
                          style: AppStyles.instrumentSans500Size14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                HomeRecommendedItemCardWidget(
                  rating: _ratings[0],
                  onRatingChanged: (newRating) {
                    setState(() {
                      _ratings[0] = newRating;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
