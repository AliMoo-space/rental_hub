import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_offers_cubit.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_requests_cubit.dart';
import 'package:rental_hub/feature/community/presentation/screens/community_screen.dart';

import 'package:rental_hub/feature/home/presentation/cubit/category_cubit.dart';
import 'package:rental_hub/feature/home/presentation/cubit/product_cubit.dart';
import 'package:rental_hub/feature/home/presentation/screens/home_screen.dart';
import 'package:rental_hub/feature/chat/presentation/cubit/conversations_cubit.dart';
import 'package:rental_hub/feature/chat/presentation/screens/conversations_screen.dart';
import 'package:rental_hub/feature/profile/presentation/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<CategoryCubit>()),
        BlocProvider(create: (context) => getIt<ProductCubit>()),
      ],
      child: const HomeScreen(),
    ),
    BlocProvider(
      create: (context) => getIt<ConversationsCubit>()..loadConversations(),
      child: const ConversationsScreen(),
    ),
    // const DealsScreen(),
    const SizedBox.shrink(),
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CommunityRequestsCubit>()
            ..loadRequests(refresh: true)
            ..loadMyRequests(),
        ),
        BlocProvider(
          create: (context) => getIt<CommunityOffersCubit>()
            ..loadIncomingOffers()
            ..loadMyOffers(),
        ),
      ],
      child: const CommunityScreen(),
    ),
    ProfileScreen(),
  ];

  void onTabTapped(int index) {
    if (index == 2) {
      context.pushNamed(AppRoutes.addListingScreen);
      return;
    }
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
                colorFilter: ColorFilter.mode(
                  currentIndex == 0
                      ? AppColors.primaryColor
                      : AppColors.bottomNavigationInactiveColor,
                  BlendMode.srcIn,
                ),
              ),
              label: context.l10n.home,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 30.w,
                AppAssets.uilMessage,
                colorFilter: ColorFilter.mode(
                  currentIndex == 1
                      ? AppColors.primaryColor
                      : AppColors.bottomNavigationInactiveColor,
                  BlendMode.srcIn,
                ),
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
                  colorFilter: const ColorFilter.mode(
                    AppColors.whiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 30.w,
                AppAssets.community,
                colorFilter: ColorFilter.mode(
                  currentIndex == 3
                      ? AppColors.primaryColor
                      : AppColors.bottomNavigationInactiveColor,
                  BlendMode.srcIn,
                ),
              ),
              label: context.l10n.community,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 28.w,
                AppAssets.profile,
                colorFilter: ColorFilter.mode(
                  currentIndex == 4
                      ? AppColors.primaryColor
                      : AppColors.bottomNavigationInactiveColor,
                  BlendMode.srcIn,
                ),
              ),
              label: context.l10n.profile,
            ),
          ],
        ),
      ),
    );
  }
}
