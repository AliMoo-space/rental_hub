import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_categories_widget.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_header_widget.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_recommended_items_list_widget.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_search_section_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<double> _ratings = List<double>.generate(6, (_) => 3.5);

  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeHeaderWidget(),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
        child: Column(
          children: [
            HomeSearchSectionWidget(
              title: context.l10n.getEverythingYouWant,
              searchHint: context.l10n.searchHint,
            ),
            HeightSpace(30),
            HomeCategoriesWidget(
              selectedCategoryIndex: _selectedCategory,
              onCategorySelected: (index) {
                setState(() {
                  _selectedCategory = index;
                });
              },
            ),
            HeightSpace(30),
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
}
