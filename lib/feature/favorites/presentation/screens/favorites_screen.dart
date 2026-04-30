import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_recommended_items_list_widget.dart';
import 'package:rental_hub/feature/favorites/presentation/widgets/favorites_widgets.dart';
import 'package:rental_hub/feature/favorites/presentation/widgets/favorites_sheets.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<double> _ratings = List<double>.generate(3, (_) => 4.0);
  int _selectedFilterIndex = 0;

  final List<String> _filters = [
    'اخر اسبوع',
    'اخر شهر',
    'اخر 3 شهور',
    'اخر 6 شهور',
    'اخر سنة',
  ];
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.l10n.favorites, style: AppStyles.hendi500Size20),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // right side: title
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'عناصرك المفضلة',
                      textAlign: TextAlign.right,
                      style: AppStyles.hendi500Size20,
                    ),
                  ),
                ),
                // left side: search + filter
                Row(
                  children: [
                    IconPill(
                      icon: Icons.search_rounded,
                      onTap: _openSearchSheet,
                    ),
                    WidthSpace(10),
                    GestureDetector(
                      onTap: _openFilterSheet,
                      child: SizedBox(
                        width: 110.w,
                        child: FilterPill(
                          label: _filters[_selectedFilterIndex],
                          trailing: Icons.keyboard_arrow_down_rounded,
                          leading: Icons.calendar_month_rounded,
                          isCompact: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            HeightSpace(14),
            Expanded(
              child: HomeRecommendedItemsListWidget(
                ratings: _ratings,
                onRatingChanged: (itemIndex, rating) {
                  setState(() {
                    _ratings[itemIndex] = rating;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => FavoritesFilterSheet(
        filters: _filters,
        selectedIndex: _selectedFilterIndex,
        onSelected: (index) {
          setState(() {
            _selectedFilterIndex = index;
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _openSearchSheet() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (context) => FavoritesSearchSheet(
        controller: _searchController,
        hintText: context.l10n.searchHint,
        onSearch: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
