import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

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
          Navigator.pop(context);
          Navigator.pushNamed(context, '/profile');
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
          Navigator.pop(context);
          Navigator.pushNamed(context, '/robot');
        },
      ),
      DrawerItem(
        icon: AppAssets.uiChat,
        title: context.l10n.messages,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/messages');
        },
      ),
      DrawerItem(
        icon: AppAssets.uiSettings,
        title: context.l10n.settings,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/settings');
        },
      ),
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeader(),

          ...items.map(
            (item) => ListTile(
              leading: SvgPicture.asset(item.icon, width: 30.w),
              title: Text(item.title, style: AppStyles.instrumentSans700Size18),
              onTap: item.onTap,
            ),
          ),

          HeightSpace(26.h),

          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 22.w),
            child: PrimaryOutlineButtonWidget(
              onPressed: () {
                Navigator.pop(context);
                // logout logic هنا
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
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Row(
        children: [
          Image.asset(AppAssets.person, width: 95.w, height: 93.h),
          SizedBox(width: 12.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("علي محمد", style: AppStyles.instrumentSans700Size24),
              Text(
                "ali.mohammed@example.com",
                style: AppStyles.instrumentSans500Size14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
