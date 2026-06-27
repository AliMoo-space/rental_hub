import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/localization/presentation/cubit/locale_cubit.dart';
import 'package:rental_hub/l10n/generated/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotificationsEnabled = true;
  bool _smsNotificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(context.l10n.settings, style: AppStyles.titleMedium),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpacing(16),
            _SettingsSection(
              title: context.l10n.accountSettings,
              children: [
                _SettingsTile(
                  icon: Icons.person_outline,
                  title: context.l10n.accountData,
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.security_outlined,
                  title: context.l10n.changePassword,
                  onTap: () {},
                ),
                BlocBuilder<LocaleCubit, LocaleState>(
                  builder: (context, localeState) {
                    final isArabic = localeState.locale.languageCode == 'ar';
                    return _SettingsTile(
                      icon: Icons.language_outlined,
                      title: context.l10n.language,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isArabic
                                ? context.l10n.arabic
                                : context.l10n.english,
                            style: AppStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondaryColor,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.g_translate_rounded,
                            size: 18.sp,
                            color: AppColors.textSecondaryColor,
                          ),
                        ],
                      ),
                      onTap: () => context.read<LocaleCubit>().toggleLanguage(
                        AppLocalizations.supportedLocales,
                      ),
                    );
                  },
                ),
              ],
            ),
            verticalSpacing(16),
            _SettingsSection(
              title: context.l10n.notificationSettings,
              children: [
                _SettingsToggleTile(
                  icon: Icons.notifications_outlined,
                  title: context.l10n.pushNotifications,
                  value: _notificationsEnabled,
                  onChanged: (v) => setState(() => _notificationsEnabled = v),
                ),
                _SettingsToggleTile(
                  icon: Icons.mail_outline,
                  title: context.l10n.emailUpdates,
                  value: _emailNotificationsEnabled,
                  onChanged: (v) =>
                      setState(() => _emailNotificationsEnabled = v),
                ),
                _SettingsToggleTile(
                  icon: Icons.sms_outlined,
                  title: context.l10n.smsNotifications,
                  value: _smsNotificationsEnabled,
                  onChanged: (v) =>
                      setState(() => _smsNotificationsEnabled = v),
                ),
              ],
            ),
            verticalSpacing(16),
            _SettingsSection(
              title: context.l10n.privacySecurity,
              children: [
                _SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: context.l10n.privacyPolicy,
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.description_outlined,
                  title: context.l10n.termsOfUse,
                  onTap: () {},
                ),
              ],
            ),
            verticalSpacing(16),
            _SettingsSection(
              title: context.l10n.support,
              children: [
                _SettingsTile(
                  icon: Icons.help_outline,
                  title: context.l10n.helpSupport,
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.mail_outline,
                  title: context.l10n.contactUs,
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.rate_review_outlined,
                  title: context.l10n.rateApp,
                  onTap: () {},
                ),
              ],
            ),
            verticalSpacing(16),
            _SettingsSection(
              title: context.l10n.aboutApp,
              children: [
                _SettingsTile(
                  icon: Icons.info_outline,
                  title: context.l10n.aboutApp,
                  subtitle: 'v1.0.0',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.update_outlined,
                  title: context.l10n.checkUpdates,
                  onTap: () {},
                ),
              ],
            ),
            verticalSpacing(32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: AppColors.errorColor,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: _showLogoutConfirmation,
                  child: Text(
                    context.l10n.disableAccount,
                    style: AppStyles.bodyLarge.copyWith(
                      color: AppColors.errorColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            verticalSpacing(32),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.confirmLogout, style: AppStyles.titleMedium),
        content: Text(
          context.l10n.logoutConfirmation,
          style: AppStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              context.l10n.cancel,
              style: AppStyles.bodyLarge.copyWith(
                color: AppColors.textSecondaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Perform logout
            },
            child: Text(
              context.l10n.logout,
              style: AppStyles.bodyLarge.copyWith(
                color: AppColors.errorColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.bodyLarge.copyWith(
              color: AppColors.textSecondaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          verticalSpacing(12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: List.generate(children.length, (index) {
                return Column(
                  children: [
                    children[index],
                    if (index < children.length - 1)
                      Divider(color: AppColors.borderColor, height: 1),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 24.w),
              horizontalSpacing(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      verticalSpacing(4),
                      Text(
                        subtitle!,
                        style: AppStyles.bodySmall.copyWith(
                          color: AppColors.textMutedColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              trailing ??
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.textMutedColor,
                    size: 16.w,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsToggleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggleTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 24.w),
          horizontalSpacing(16),
          Expanded(
            child: Text(
              title,
              style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
