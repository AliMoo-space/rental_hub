import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/custom_text_field.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<double> _ratings = List<double>.generate(6, (_) => 3.5);
  final List<String> _categories = const [
    'الكل',
    'كراسي',
    'طاولات',
    'غرف نوم',
    'مكاتب',
    'ديكور',
  ];

  int _selectedCategory = 0;

  Widget _buildInteractiveStars(int itemIndex) {
    const totalStars = 5;
    final rating = _ratings[itemIndex];
    final fullStars = rating.floor();
    final hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalStars, (starIndex) {
        final isFull = starIndex < fullStars;
        final isHalf = starIndex == fullStars && hasHalfStar;

        IconData icon;
        if (isFull) {
          icon = Icons.star_rounded;
        } else if (isHalf) {
          icon = Icons.star_half_rounded;
        } else {
          icon = Icons.star_outline_rounded;
        }

        return Padding(
          padding: EdgeInsetsDirectional.only(start: starIndex == 0 ? 0 : 4.w),
          child: InkResponse(
            onTap: () {
              setState(() {
                _ratings[itemIndex] = starIndex + 1.0;
              });
            },
            radius: 14.r,
            splashColor: const Color(0xffF7B500).withValues(alpha: 0.2),
            highlightColor: Colors.transparent,
            child: Icon(
              icon,
              size: 18.sp,
              color: (isFull || isHalf)
                  ? const Color(0xffF7B500)
                  : AppColors.secondaryColor,
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 100.h,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: SvgPicture.asset(AppAssets.logo2, width: 151.w),
        actions: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.backgroundColor,
                radius: 18.r,
                child: SvgPicture.asset(AppAssets.bell, width: 30.w),
              ),
              SizedBox(width: 16.w),
              Image.asset(AppAssets.person, width: 36.w),
              SizedBox(width: 16.w),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                context.l10n.getEverythingYouWant,
                style: AppStyles.intro32semiBold.copyWith(fontSize: 20.sp),
              ),
            ),
            HeightSpace(9),
            CustomTextField(
              width: 364.w,
              hintText: context.l10n.searchHint,
              suffixIcon: Icon(
                Icons.search_rounded,
                size: 33.sp,
                color: AppColors.secondaryColor,
              ),
            ),
            HeightSpace(30),
            SizedBox(
              height: 50.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedCategory;
                  return Container(
                    margin: EdgeInsetsDirectional.only(end: 10.w),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30.r),
                      onTap: () {
                        setState(() {
                          _selectedCategory = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: AppColors.smallSecondaryColor.withValues(
                                  alpha: .2,
                                ),
                                blurRadius: 12.r,
                                offset: Offset(0, 4.h),
                              ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            _categories[index],
                            style: AppStyles.intro16medium.copyWith(
                              fontSize: 13.sp,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.smallSecondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            HeightSpace(30),

            //متنساش تكتب الجمله بتاعة تم العثور
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsetsDirectional.only(bottom: 18.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .06),
                          blurRadius: 16.r,
                          offset: Offset(0, 7.h),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 375.w,
                            height: 234.h,
                            child: Image.asset(
                              AppAssets.modernChair,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: .55),
                                  ],
                                  stops: const [0.35, 1.0],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12.h,
                            left: 14.w,
                            right: 321.w,
                            child: CircleAvatar(
                              radius: 16.r,
                              backgroundColor: Color(
                                0xffFFFFFF,
                              ).withValues(alpha: .8),
                              child: SvgPicture.asset(
                                AppAssets.uiHeart,
                                width: 24.w,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 11.h,
                            right: 9.w,
                            left: 9.w,
                            child: Container(
                              width: 357.w,
                              padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 14.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffFFFFFF).withValues(alpha: .8),
                                borderRadius: BorderRadiusDirectional.all(
                                  Radius.circular(12.r),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.uilLocation),
                                      WidthSpace(6),
                                      Expanded(
                                        child: Text(
                                          'مدينة نصر',
                                          style:
                                              AppStyles.instrumentSans500Size14,
                                        ),
                                      ),
                                      WidthSpace(8),
                                      Flexible(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: _buildInteractiveStars(
                                              index,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  HeightSpace(8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'كرسي ديكور',
                                        style: AppStyles.instrumentSans700Size24
                                            .copyWith(
                                              color: AppColors.secondaryColor,
                                            ),
                                      ),
                                      Text(
                                        '250 ج.م/اليوم',
                                        style: AppStyles.instrumentSans700Size24
                                            .copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                      ),
                                    ],
                                  ),

                                  HeightSpace(10),
                                  PrimaryButtonWidget(
                                    width: double.infinity,
                                    height: 31.h,
                                    buttonText: 'عرض المنتج',

                                    fontSize: 12.sp,
                                    style: AppStyles.instrumentSans700Size24
                                        .copyWith(
                                          fontSize: 12.sp,
                                          color: Color(0xff6A72F5),
                                        ),
                                    buttonColor: Color(0xffCBCEFF),
                                    bordersRadius: 20.r,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
