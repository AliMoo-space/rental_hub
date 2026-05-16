import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

/// Settings screen with various app and account settings
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
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: Text(context.l10n.settings, style: AppStyles.titleMedium),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpacing(16),

            // Account Settings Section
            _SettingsSection(
              title: 'حساب',
              children: [
                _SettingsTile(
                  icon: Icons.person_outline,
                  title: 'بيانات الحساب',
                  onTap: () {
                    // Navigate to account settings
                  },
                ),
                _SettingsTile(
                  icon: Icons.security_outlined,
                  title: 'تغيير كلمة المرور',
                  onTap: () {
                    // Navigate to change password
                  },
                ),
                _SettingsTile(
                  icon: Icons.language_outlined,
                  title: 'اللغة',
                  onTap: () {
                    // Change language
                  },
                ),
              ],
            ),
            verticalSpacing(16),

            // Notification Settings
            _SettingsSection(
              title: 'التنبيهات والإشعارات',
              children: [
                _SettingsToggleTile(
                  icon: Icons.notifications_outlined,
                  title: 'تنبيهات التطبيق',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                  },
                ),
                _SettingsToggleTile(
                  icon: Icons.mail_outline,
                  title: 'تحديثات البريد الإلكتروني',
                  value: _emailNotificationsEnabled,
                  onChanged: (value) {
                    setState(() => _emailNotificationsEnabled = value);
                  },
                ),
                _SettingsToggleTile(
                  icon: Icons.sms_outlined,
                  title: 'رسائل نصية',
                  value: _smsNotificationsEnabled,
                  onChanged: (value) {
                    setState(() => _smsNotificationsEnabled = value);
                  },
                ),
              ],
            ),
            verticalSpacing(16),

            // Privacy & Security
            _SettingsSection(
              title: 'الخصوصية والأمان',
              children: [
                _SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'سياسة الخصوصية',
                  onTap: () {
                    // Open privacy policy
                  },
                ),
                _SettingsTile(
                  icon: Icons.description_outlined,
                  title: 'شروط الاستخدام',
                  onTap: () {
                    // Open terms of service
                  },
                ),
              ],
            ),
            verticalSpacing(16),

            // Support
            _SettingsSection(
              title: 'دعم',
              children: [
                _SettingsTile(
                  icon: Icons.help_outline,
                  title: 'المساعدة والدعم',
                  onTap: () {
                    // Open help center
                  },
                ),
                _SettingsTile(
                  icon: Icons.mail_outline,
                  title: 'اتصل بنا',
                  onTap: () {
                    // Open contact form
                  },
                ),
                _SettingsTile(
                  icon: Icons.rate_review_outlined,
                  title: 'قيم التطبيق',
                  onTap: () {
                    // Open app store to rate
                  },
                ),
              ],
            ),
            verticalSpacing(16),

            // About
            _SettingsSection(
              title: 'حول التطبيق',
              children: [
                _SettingsTile(
                  icon: Icons.info_outline,
                  title: 'عن التطبيق',
                  subtitle: 'v1.0.0',
                  onTap: () {
                    // Show about dialog
                  },
                ),
                _SettingsTile(
                  icon: Icons.update_outlined,
                  title: 'البحث عن التحديثات',
                  onTap: () {
                    // Check for updates
                  },
                ),
              ],
            ),
            verticalSpacing(32),

            // Danger Zone
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(
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
                      onPressed: () {
                        // Logout
                        _showLogoutConfirmation();
                      },
                      child: Text(
                        'تعطيل الحساب',
                        style: AppStyles.bodyLarge.copyWith(
                          color: AppColors.errorColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
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
      builder: (context) => AlertDialog(
        title: Text('تأكيد تسجيل الخروج', style: AppStyles.titleMedium),
        content: Text(
          'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
          style: AppStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.l10n.cancel,
              style: AppStyles.bodyLarge.copyWith(
                color: AppColors.textSecondaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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
              children: List.generate(
                children.length,
                (index) => Column(
                  children: [
                    children[index],
                    if (index < children.length - 1)
                      Divider(color: AppColors.borderColor, height: 1),
                  ],
                ),
              ),
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
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
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
  final Function(bool) onChanged;

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
