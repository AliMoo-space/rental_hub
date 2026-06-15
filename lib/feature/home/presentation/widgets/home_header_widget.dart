import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/feature/profile/presentation/cubit/user_profile_cubit.dart';
import 'package:rental_hub/feature/profile/presentation/cubit/user_profile_state.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/feature/notifications/presentation/cubit/notification_cubit.dart';
import 'package:rental_hub/feature/notifications/presentation/cubit/notification_state.dart';

class HomeHeaderWidget extends StatefulWidget implements PreferredSizeWidget {
  const HomeHeaderWidget({super.key});

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(100.h);
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      getIt<NotificationCubit>().fetchUnreadCount();
    });
  }

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
            BlocProvider.value(
              value: getIt<NotificationCubit>(),
              child: BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  int unreadCount = 0;
                  if (state is NotificationLoaded) {
                    unreadCount = state.unreadCount;
                  }
                  
                  return GestureDetector(
                    onTap: () => context.pushNamed(AppRoutes.notificationsScreen),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.backgroundColor,
                          radius: 20.r,
                          child: SvgPicture.asset(AppAssets.bell, width: 30.w),
                        ),
                        if (unreadCount > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.all(4.r),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                unreadCount > 99 ? '99+' : unreadCount.toString(),
                                style: AppStyles.labelSmall.copyWith(color: Colors.white, fontSize: 8.sp),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 16.w),
            BlocBuilder<UserProfileCubit, UserProfileState>(
              builder: (context, state) {
                final imageUrl = state.userProfile?.profileImage ?? '';
                return GestureDetector(
                  onTap: () => context.pushNamed(AppRoutes.userProfileScreen),
                  child: CircleAvatar(
                    radius: 18.r,
                    backgroundColor: AppColors.backgroundColor,
                    backgroundImage: imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : null,
                    child: imageUrl.isEmpty
                        ? Image.asset(AppAssets.person, width: 36.w)
                        : null,
                  ),
                );
              },
            ),
            SizedBox(width: 16.w),
          ],
        ),
      ],
    );
  }
}
