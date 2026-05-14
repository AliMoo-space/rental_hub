import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/condition_toggle_button.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/dashed_upload_box.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/labeled_text_field.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/listing_card.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/picker_field.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/price_field.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();
  final TextEditingController _dailyPriceController = TextEditingController();
  final TextEditingController _securityDepositController =
      TextEditingController();

  bool _isNewCondition = true;

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemDescriptionController.dispose();
    _dailyPriceController.dispose();
    _securityDepositController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: Text(context.l10n.addListing, style: AppStyles.hendi500Size20),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 18.h,
        ),
        child: Column(
          children: [
            ListingCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.productMedia,
                        style: AppStyles.titleMedium.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        '0/10',
                        style: AppStyles.bodySmall.copyWith(
                          color: AppColors.smallSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: DashedUploadBox(
                      width: 104.w,
                      height: 104.w,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            ListingCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.chooseCategory,
                    style: AppStyles.titleMedium.copyWith(
                      color: AppColors.secondaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const PickerField(hintText: 'الإلكترونيات'),
                  SizedBox(height: 10.h),
                  const PickerField(hintText: 'لابتوب'),
                  SizedBox(height: 18.h),
                  Text(
                    context.l10n.location,
                    style: AppStyles.titleMedium.copyWith(
                      color: AppColors.secondaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const PickerField(hintText: 'المدينة'),
                  SizedBox(height: 10.h),
                  const PickerField(hintText: 'المنطقة'),
                  SizedBox(height: 18.h),
                  Text(
                    context.l10n.condition,
                    style: AppStyles.titleMedium.copyWith(
                      color: AppColors.secondaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: ConditionToggleButton(
                          text: 'جديد',
                          isSelected: _isNewCondition,
                          onTap: () {
                            setState(() {
                              _isNewCondition = true;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: ConditionToggleButton(
                          text: 'مستعمل',
                          isSelected: !_isNewCondition,
                          onTap: () {
                            setState(() {
                              _isNewCondition = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  LabeledTextField(
                    label: context.l10n.itemName,
                    controller: _itemNameController,
                    hintText: 'اكتب هنا..',
                  ),
                  SizedBox(height: 16.h),
                  LabeledTextField(
                    label: context.l10n.itemDescription,
                    controller: _itemDescriptionController,
                    hintText: 'اكتب هنا..',
                    maxLines: 4,
                  ),
                  SizedBox(height: 18.h),
                  Row(
                    children: [
                      Expanded(
                        child: PriceField(
                          label: context.l10n.rentalPricePerDay,
                          controller: _dailyPriceController,
                          suffix: 'ج.م',
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: PriceField(
                          label: context.l10n.securityDeposit,
                          controller: _securityDepositController,
                          suffix: 'ج.م',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            ListingCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.productConditionReport,
                              style: AppStyles.titleMedium.copyWith(
                                color: AppColors.secondaryColor,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              context.l10n.uploadPhotosNote,
                              style: AppStyles.bodySmall.copyWith(
                                color: AppColors.smallSecondaryColor,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Icon(
                        Icons.shield_moon,
                        color: AppColors.primaryColor,
                        size: 30.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: DashedUploadBox(
                      width: 104.w,
                      height: 104.w,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),
            PrimaryButtonWidget(
              buttonText: context.l10n.addProduct,
              onPress: () {
                context.goNamed(AppRoutes.mainScreen);
              },
              width: 331.w,
              height: 48.h,
              icon: Container(
                width: 22.w,
                height: 22.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppAssets.uiPlus,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              style: AppStyles.hendi500Size20.copyWith(
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 10.h),
            PrimaryOutlineButtonWidget(
              text: 'إلغاء',
              onPressed: () {
                context.pop();
              },
              textColor: AppColors.secondaryColor,
              borderColor: AppColors.borderColor,
              borderRadius: 28.r,
              width: 331.w,
              height: 48.h,
              fontSize: 15.sp,
            ),
          ],
        ),
      ),
    );
  }
}
