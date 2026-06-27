import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

enum OrderEmptyType { noOrders, searchResults }

class OrderEmptyState extends StatelessWidget {
  final OrderEmptyType type;
  final String? searchQuery;

  const OrderEmptyState({
    super.key,
    this.type = OrderEmptyType.noOrders,
    this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    final icon = switch (type) {
      OrderEmptyType.noOrders => Icons.receipt_long_outlined,
      OrderEmptyType.searchResults => Icons.search_off_rounded,
    };

    final title = switch (type) {
      OrderEmptyType.noOrders => context.l10n.noOrders,
      OrderEmptyType.searchResults => context.l10n.noSearchResults,
    };

    final subtitle = switch (type) {
      OrderEmptyType.noOrders => null,
      OrderEmptyType.searchResults =>
        searchQuery != null ? '"$searchQuery"' : null,
    };

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColors.primarySoftColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 36.sp, color: AppColors.primaryColor),
            ),
            HeightSpace(20),
            Text(
              title,
              style: AppStyles.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              HeightSpace(8),
              Text(
                subtitle,
                style: AppStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
