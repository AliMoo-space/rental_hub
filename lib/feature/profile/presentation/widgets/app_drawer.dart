import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/databases/cache/cache_helper.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/localization/presentation/cubit/locale_cubit.dart';
import 'package:rental_hub/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:rental_hub/l10n/generated/app_localizations.dart';
import 'package:rental_hub/feature/profile/presentation/cubit/user_profile_cubit.dart';
import 'package:rental_hub/feature/profile/presentation/cubit/user_profile_state.dart';
import 'package:rental_hub/feature/theme/presentation/cubit/theme_cubit.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _DrawerItemData(
        icon: AppAssets.uiUser,
        title: context.l10n.manageAccount,
        onTap: () => context.pushNamed(AppRoutes.userProfileScreen),
      ),
      _DrawerItemData(
        icon: AppAssets.uiWallet,
        title: context.l10n.wallet,
        onTap: () => context.pushNamed(AppRoutes.walletScreen),
      ),
      _DrawerItemData(
        icon: AppAssets.uiVector,
        title: context.l10n.deals,
        onTap: () => context.pushNamed(AppRoutes.dealsScreen),
      ),
      _DrawerItemData(
        icon: AppAssets.solarHeart,
        title: context.l10n.favorites,
        onTap: () => context.pushNamed(AppRoutes.favoritesScreen),
      ),
      _DrawerItemData(
        icon: AppAssets.mdiRobot,
        title: context.l10n.robot,
        onTap: () => context.pushNamed(AppRoutes.aiChatScreen),
      ),
      _DrawerItemData(
        icon: AppAssets.uiChat,
        title: context.l10n.messages,
        onTap: () {},
      ),
      _DrawerItemData(
        icon: AppAssets.uiSettings,
        title: context.l10n.settings,
        onTap: () => context.pushNamed(AppRoutes.settingsScreen),
      ),
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          BlocBuilder<UserProfileCubit, UserProfileState>(
            builder: (context, state) => _DrawerHeader(
              profile: state.userProfile ?? const UserProfileEntity(),
              isLoading: state is UserProfileLoading,
            ),
          ),
          ...items.map(
            (item) => ListTile(
              leading: SvgPicture.asset(item.icon, width: 30.w),
              title: Text(item.title, style: AppStyles.instrumentSans700Size18),
              onTap: item.onTap,
            ),
          ),
          BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, localeState) {
              final localeCode = localeState.locale.languageCode;
              return ListTile(
                leading: Icon(Icons.language, size: 30.sp),
                title: Text(
                  context.l10n.language,
                  style: AppStyles.instrumentSans700Size18,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localeCode == 'ar'
                          ? context.l10n.arabic
                          : context.l10n.english,
                      style: AppStyles.instrumentSans500Size14,
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14.sp,
                      color: AppColors.textMutedColor,
                    ),
                  ],
                ),
                onTap: () => _showLanguageSheet(context, localeCode),
              );
            },
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              final isDark = state.themeMode == ThemeMode.dark;
              return ListTile(
                leading: Icon(
                  isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  size: 30.sp,
                ),
                title: Text(
                  isDark ? context.l10n.lightMode : context.l10n.darkMode,
                  style: AppStyles.instrumentSans700Size18,
                ),
                onTap: () => context.read<ThemeCubit>().toggleTheme(),
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

class _DrawerItemData {
  final String icon;
  final String title;
  final VoidCallback onTap;

  _DrawerItemData({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

void _showLanguageSheet(BuildContext context, String currentLanguageCode) {
  final supportedLocales = AppLocalizations.supportedLocales;
  final l10n = context.l10n;

  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                l10n.language,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            ...supportedLocales.map((locale) {
              final isSelected = locale.languageCode == currentLanguageCode;
              final name = locale.languageCode == 'ar'
                  ? l10n.arabic
                  : l10n.english;
              return ListTile(
                title: Text(name),
                trailing: isSelected
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () async {
                  await context.read<LocaleCubit>().setLanguage(
                    languageCode: locale.languageCode,
                    supportedLocales: supportedLocales,
                  );
                  if (sheetContext.mounted) {
                    Navigator.of(sheetContext).pop();
                  }
                },
              );
            }),
          ],
        ),
      );
    },
  );
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
                    ? context.l10n.loadingProfile
                    : (profile.fullName.isNotEmpty
                          ? profile.fullName
                          : context.l10n.guestUser),
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
