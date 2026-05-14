import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';

class HomeHeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeaderWidget({super.key});

  @override
  Size get preferredSize => Size.fromHeight(100.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100.h,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: SvgPicture.asset(AppAssets.logo2, width: 151.w),
      actions: [
        Row(
          children: [
            GestureDetector(
              onTap: () => context.pushNamed(AppRoutes.settingsScreen),
              child: CircleAvatar(
                backgroundColor: AppColors.backgroundColor,
                radius: 20.r,
                child: SvgPicture.asset(AppAssets.bell, width: 30.w),
              ),
            ),
            SizedBox(width: 16.w),
            GestureDetector(
              onTap: () => context.pushNamed(AppRoutes.editProfileScreen),
              child: Image.asset(AppAssets.person, width: 36.w),
            ),
            SizedBox(width: 16.w),
          ],
        ),
      ],
    );
  }
}
