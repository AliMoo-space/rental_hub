import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/widgets/custom_text_field.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class FavoritesSearchSheet extends StatelessWidget {
  const FavoritesSearchSheet({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSearch,
  });

  final TextEditingController controller;
  final String hintText;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        color: Colors.white,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: controller,
              hintText: hintText,
              suffixIcon: IconButton(
                onPressed: onSearch,
                icon: Icon(Icons.search_rounded, color: AppColors.primaryColor),
              ),
            ),
            HeightSpace(12),
          ],
        ),
      ),
    );
  }
}

class FavoritesFilterSheet extends StatelessWidget {
  const FavoritesFilterSheet({
    super.key,
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < filters.length; i++)
            ListTile(
              title: Text(filters[i]),
              trailing: i == selectedIndex
                  ? Icon(Icons.check, color: AppColors.primaryColor)
                  : null,
              onTap: () => onSelected(i),
            ),
        ],
      ),
    );
  }
}
