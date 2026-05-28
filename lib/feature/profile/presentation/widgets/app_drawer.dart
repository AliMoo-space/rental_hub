import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/databases/cache/cache_helper.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:rental_hub/feature/profile/presentation/cubit/user_profile_cubit.dart';
import 'package:rental_hub/feature/profile/presentation/cubit/user_profile_state.dart';
import 'package:rental_hub/feature/theme/presentation/cubit/theme_cubit.dart';

class DrawerItem {
  final String icon;
  final String title;
  final VoidCallback onTap;

  DrawerItem({required this.icon, required this.title, required this.onTap});
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      DrawerItem(
        icon: AppAssets.uiUser,
        title: context.l10n.manageAccount,
        onTap: () {
          context.pushNamed(AppRoutes.userProfileScreen);
        },
      ),
      DrawerItem(
        icon: AppAssets.uiWallet,
        title: context.l10n.wallet,
        onTap: () {
          context.pushNamed(AppRoutes.walletScreen);
        },
      ),
      DrawerItem(
        icon: AppAssets.uiVector,
        title: context.l10n.deals,
        onTap: () {
          context.pushNamed(AppRoutes.dealsScreen);
        },
      ),
      DrawerItem(
        icon: AppAssets.solarHeart,
        title: context.l10n.favorites,
        onTap: () {
          context.pushNamed(AppRoutes.favoritesScreen);
        },
      ),
      DrawerItem(
        icon: AppAssets.mdiRobot,
        title: context.l10n.robot,
        onTap: () {
          context.pushNamed(AppRoutes.aiChatScreen);
        },
      ),
      DrawerItem(
        icon: AppAssets.uiChat,
        title: context.l10n.messages,
        onTap: () {},
      ),
      DrawerItem(
        icon: AppAssets.uiSettings,
        title: context.l10n.settings,
        onTap: () {
          context.pushNamed(AppRoutes.settingsScreen);
        },
      ),
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          BlocBuilder<UserProfileCubit, UserProfileState>(
            builder: (context, state) {
              return _DrawerHeader(
                profile: state.userProfile ?? const UserProfileEntity(),
                isLoading: state is UserProfileLoading,
              );
            },
          ),
          ...items.map(
            (item) => ListTile(
              leading: SvgPicture.asset(item.icon, width: 30.w),
              title: Text(item.title, style: AppStyles.instrumentSans700Size18),
              onTap: item.onTap,
            ),
          ),

          // Theme Toggle
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return ListTile(
                leading: Icon(
                  state.themeMode == ThemeMode.dark
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                  size: 30.sp,
                ),
                title: Text(
                  state.themeMode == ThemeMode.dark
                      ? 'Light Mode'
                      : 'Dark Mode',
                  style: AppStyles.instrumentSans700Size18,
                ),
                onTap: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
              );
            },
          ),

          HeightSpace(26.h),

          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 22.w),
            child: PrimaryOutlineButtonWidget(
              onPressed: () async {
                await getIt<CacheHelper>().clearSecureData();
                if (!context.mounted) return;
                context.pushNamed(AppRoutes.animatedAuthToggle);
              },
              text: context.l10n.logout,
            ),
          ),

          HeightSpace(26.h),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final UserProfileEntity profile;
  final bool isLoading;

  const _DrawerHeader({required this.profile, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Row(
        children: [
          CircleAvatar(
            radius: 52.r,
            backgroundColor: Colors.black87.withValues(alpha: 0.12),

            child: ClipOval(
              child: profile.profileImage.isNotEmpty
                  ? Image.network(
                      profile.profileImage,
                      width: 95.w,
                      height: 93.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
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
          SizedBox(width: 12.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isLoading && profile.fullName.isEmpty
                    ? 'جارٍ تحميل الملف'
                    : (profile.fullName.isNotEmpty
                          ? profile.fullName
                          : 'علي محمد'),
                style: AppStyles.instrumentSans700Size24,
              ),
              Text(
                profile.phoneNumber.isNotEmpty ? profile.phoneNumber : ' ',
                style: AppStyles.instrumentSans500Size14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
