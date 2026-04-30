import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/feature/community/presentation/screens/community_screen.dart';
import 'package:rental_hub/feature/home/presentation/screens/home_screen.dart';
import 'package:rental_hub/feature/profile/presentation/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    Container(color: Colors.blue),
    Container(color: Colors.red),
    CommunityScreen(),
    ProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(20.r),
          topEnd: Radius.circular(20.r),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: currentIndex,
          onTap: onTabTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.bottomNavigationInactiveColor,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 30.w,
                AppAssets.homeOutline,
                color: currentIndex == 0
                    ? AppColors.primaryColor
                    : AppColors.bottomNavigationInactiveColor,
              ),
              label: context.l10n.home,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 30.w,
                AppAssets.uilMessage,
                color: currentIndex == 1
                    ? AppColors.primaryColor
                    : AppColors.bottomNavigationInactiveColor,
              ),
              label: context.l10n.messages,
            ),

            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primarySoftColor,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  width: 30.w,
                  AppAssets.uiPlus,
                  color: AppColors.whiteColor,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 30.w,
                AppAssets.community,
                color: currentIndex == 3
                    ? AppColors.primaryColor
                    : AppColors.bottomNavigationInactiveColor,
              ),
              label: context.l10n.community,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 28.w,
                AppAssets.profile,
                color: currentIndex == 4
                    ? AppColors.primaryColor
                    : AppColors.bottomNavigationInactiveColor,
              ),
              label: context.l10n.profile,
            ),
          ],
        ),
      ),
    );
  }
}
