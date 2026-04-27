import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/feature/home/presentation/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),

    Container(color: Colors.green),
    Container(color: Colors.blue),
    Container(color: Colors.red),
    Container(color: Colors.amber),
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
          selectedItemColor: const Color(0xFF6A72F5),
          unselectedItemColor: Colors.grey,

          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 30.w,

                AppAssets.homeOutline,
                color: currentIndex == 0
                    ? const Color(0xFF6A72F5)
                    : Colors.grey,
              ),
              label: context.l10n.home,
            ),

            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 30.w,

                AppAssets.community,
                color: currentIndex == 1
                    ? const Color(0xFF6A72F5)
                    : Colors.grey,
              ),
              label: context.l10n.community,
            ),

            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xffCBCEFF),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  width: 30.w,
                  AppAssets.uiPlus,
                  color: Colors.white,
                ),
              ),
              label: '',
            ),

            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 30.w,
                AppAssets.uilMessage,
                color: currentIndex == 3
                    ? const Color(0xFF6A72F5)
                    : Colors.grey,
              ),
              label: context.l10n.messages,
            ),

            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 28.w,
                AppAssets.profile,
                color: currentIndex == 4
                    ? const Color(0xFF6A72F5)
                    : Colors.grey,
              ),
              label: context.l10n.profile,
            ),
          ],
        ),
      ),
    );
  }
}
