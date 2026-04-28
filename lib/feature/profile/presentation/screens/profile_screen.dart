import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_recommended_item_card_widget.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_recommended_items_list_widget.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200.h,
              color: AppColors.primaryColor,
            ),
            Transform.translate(
              offset: Offset(0, -50),
              child: Column(
                children: [
                  Image.asset(AppAssets.person, width: 95.w, height: 93.h),
                  HeightSpace(12),
                  Text("علي محمد", style: AppStyles.instrumentSans700Size24),
                ],
              ),
            ),
            PrimaryButtonWidget(
              buttonText: context.l10n.addListing,
              onPress: () {},
              buttonColor: AppColors.primaryColor,
              style: AppStyles.hendi500Size20.copyWith(
                color: Colors.white,
                fontSize: 15.sp,
              ),
              width: 260.w,
              height: 44.h,
            ),
            PrimaryOutlineButtonWidget(
              text: context.l10n.addQuestion,
              onPressed: () {},
              textColor: AppColors.secondaryColor,
              borderRadius: 30.r,
              borderColor: AppColors.secondaryColor,
              width: 260.w,
              height: 44.h,
            ),
            PrimaryOutlineButtonWidget(
              text: context.l10n.editProfile,
              onPressed: () {},
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
                  Text(
                    context.l10n.viewAll,
                    style: AppStyles.instrumentSans500Size14.copyWith(
                      fontWeight: FontWeight.bold,
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
                  Text(
                    context.l10n.viewAll,
                    style: AppStyles.instrumentSans500Size14.copyWith(
                      fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
