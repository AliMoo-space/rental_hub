import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_shadows.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/deals_filter_header_widget.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_header_widget.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<String> _filters = ['All', 'Today', 'This Week', 'This Month'];
  int _selectedFilterIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeHeaderWidget(),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600.w),
          child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 18.w,
              vertical: 20.h,
            ),
            child: Column(
              children: [
                _CreateCommunityPostCard(),
                SizedBox(height: 14.h),
                FilterHeaderWidget(
                  title: 'عروض المجتمع',
                  selectedFilter: _filters[_selectedFilterIndex],
                  onSearchTap: () {},
                  onFilterTap: () {},
                ),
                SizedBox(height: 14.h),
                const _CommunityOfferCard(),
                SizedBox(height: 14.h),
                const _CommunityOfferCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateCommunityPostCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [AppShadows.softCard],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColors.surfaceVariantColor,
                child: Icon(
                  Icons.person,
                  size: 20.sp,
                  color: AppColors.smallSecondaryColor,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'هل تود إضافة عرض؟',
                textAlign: TextAlign.end,
                style: AppStyles.inputHint.copyWith(
                  color: AppColors.smallSecondaryColor,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(height: 1.h, color: AppColors.borderColor),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _PostActionChip(
                  label: 'صورة',
                  icon: Icons.image_outlined,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _PostActionChip(
                  label: 'حدد السعر',
                  icon: Icons.payments_outlined,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _PostActionChip(
                  label: 'مدة الإيجار',
                  icon: Icons.calendar_month_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PostActionChip extends StatelessWidget {
  const _PostActionChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: AppStyles.bodySmall.copyWith(
                color: AppColors.smallSecondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 11.sp,
              ),
            ),
          ),
          SizedBox(width: 6.w),
          Icon(icon, size: 16.sp, color: AppColors.smallSecondaryColor),
        ],
      ),
    );
  }
}

class _CommunityOfferCard extends StatelessWidget {
  const _CommunityOfferCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [AppShadows.softCard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: AppColors.surfaceVariantColor,
                child: Icon(
                  Icons.person,
                  size: 20.sp,
                  color: AppColors.smallSecondaryColor,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'سارة هاني',
                textAlign: TextAlign.end,
                style: AppStyles.hendi500Size20,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            'أحتاج كاميرا احترافية لمدة يومين للتصوير في مناسبات خاصة',
            textAlign: TextAlign.start,
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.smallSecondaryColor,
              height: 1.6,
            ),
          ),
          SizedBox(height: 14.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: const [
              _InfoTag(icon: Icons.location_on_outlined, text: 'القاهرة'),
              _InfoTag(icon: Icons.access_time, text: 'منذ ساعتين'),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                'تقديم طلب',
                style: AppStyles.buttonLabel.copyWith(fontSize: 15.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTag extends StatelessWidget {
  const _InfoTag({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF0EEFF),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.smallSecondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(width: 6.w),
          Icon(icon, size: 16.sp, color: AppColors.primaryColor),
        ],
      ),
    );
  }
}
