import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/search/domain/entities/live_suggestion_entity.dart';

class LiveSuggestionsDropdown extends StatelessWidget {
  final List<LiveSuggestionEntity> suggestions;
  final ValueChanged<LiveSuggestionEntity> onTap;

  const LiveSuggestionsDropdown({
    super.key,
    required this.suggestions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 320.h),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        shrinkWrap: true,
        itemCount: suggestions.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1.h, thickness: 1, color: AppColors.borderColor),
        itemBuilder: (context, index) {
          final item = suggestions[index];
          return InkWell(
            onTap: () => onTap(item),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              child: Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariantColor,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Icon(
                      Icons.search_rounded,
                      color: AppColors.primaryColor,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.bodyLarge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${item.category} • ${item.pricePerDay.toStringAsFixed(0)} / day',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.north_west_rounded,
                    color: AppColors.textSecondary,
                    size: 18.sp,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
