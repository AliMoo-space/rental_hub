import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/deals_filter_header_widget.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/deals/presentation/widgets/deals_widgets.dart';
import 'package:rental_hub/feature/favorites/presentation/widgets/favorites_sheets.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_recommended_items_list_widget.dart';

class DealsScreen extends StatefulWidget {
  const DealsScreen({super.key});

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  final List<double> _ratings = List<double>.generate(3, (_) => 4.0);
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'اخر اسبوع',
    'اخر شهر',
    'اخر 3 شهور',
    'اخر 6 شهور',
    'اخر سنة',
  ];

  int _selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.l10n.deals, style: AppStyles.hendi500Size20),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 10.h,
          ),
          child: Column(
            children: [
              FilterHeaderWidget(
                title: context.l10n.myRentals,
                selectedFilter: _filters[_selectedFilterIndex],
                onSearchTap: _openSearchSheet,
                onFilterTap: _openFilterSheet,
              ),

              HeightSpace(12),
              HomeRecommendedItemsListWidget(
                ratings: _ratings,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onRatingChanged: (itemIndex, rating) {
                  setState(() {
                    _ratings[itemIndex] = rating;
                  });
                },
              ),
              HeightSpace(6),
              SizedBox(
                width: double.infinity,
                child: PrimaryOutlineButtonWidget(
                  onPressed: () {},
                  text: context.l10n.viewAll,
                  textColor: AppColors.secondaryColor,
                  borderColor: AppColors.secondaryColor,
                  borderRadius: 14.r,
                  width: double.infinity,
                  height: 42.h,
                  fontSize: 14.sp,
                ),
              ),
              HeightSpace(20),
              Divider(
                color: AppColors.borderColor,
                thickness: 1,
                indent: 16.w,
                endIndent: 16.w,
              ),
              HeightSpace(20),
              FilterHeaderWidget(
                title: context.l10n.myRentals,
                selectedFilter: _filters[_selectedFilterIndex],
                onSearchTap: _openSearchSheet,
                onFilterTap: _openFilterSheet,
              ),

              HeightSpace(12),
              DealsCompactItemTile(
                title: 'كاميرا (Canon)',
                subtitle: 'أدوات تصوير',
                price: '150 ج.م/اليوم',
                onTap: () {},
              ),
              DealsCompactItemTile(
                title: 'كاميرا احترافية',
                subtitle: 'أدوات تصوير',
                price: '200 ج.م/اليوم',
                onTap: () {},
              ),
              DealsCompactItemTile(
                title: 'عدسة تصوير',
                subtitle: 'أدوات تصوير',
                price: '100 ج.م/اليوم',
                onTap: () {},
              ),
              HeightSpace(8),
              SizedBox(
                width: double.infinity,
                child: PrimaryOutlineButtonWidget(
                  onPressed: () {},
                  text: context.l10n.viewAll,
                  textColor: AppColors.secondaryColor,
                  borderColor: AppColors.secondaryColor,
                  borderRadius: 14.r,
                  width: double.infinity,
                  height: 42.h,
                  fontSize: 14.sp,
                ),
              ),
              HeightSpace(20),
            ],
          ),
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
