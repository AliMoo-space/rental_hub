import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/favorites/presentation/widgets/favorites_sheets.dart';
import 'package:rental_hub/feature/favorites/presentation/widgets/favorites_widgets.dart';

class RentalsHeader extends StatelessWidget {
  final String title;
  final List<String> filters;
  final int selectedFilterIndex;
  final VoidCallback onSearchTap;
  final Function(int) onFilterSelected;

  const RentalsHeader({
    super.key,
    required this.title,
    required this.filters,
    required this.selectedFilterIndex,
    required this.onSearchTap,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// 🔹 Title
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              title,
              textAlign: TextAlign.right,
              style: AppStyles.hendi500Size20,
            ),
          ),
        ),

        /// 🔹 Actions (Search + Filter)
        Row(
          children: [
            IconPill(icon: Icons.search_rounded, onTap: onSearchTap),
            WidthSpace(10),
            GestureDetector(
              onTap: () => _openFilterSheet(context),
              child: SizedBox(
                width: 110.w,
                child: FilterPill(
                  label: filters[selectedFilterIndex],
                  trailing: Icons.keyboard_arrow_down_rounded,
                  leading: Icons.calendar_month_rounded,
                  isCompact: false,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => FavoritesFilterSheet(
        filters: filters,
        selectedIndex: selectedFilterIndex,
        onSelected: (index) {
          onFilterSelected(index);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
