import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/widgets/loading_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/home/presentation/cubit/category_cubit.dart';
import 'package:rental_hub/feature/home/presentation/cubit/product_cubit.dart';
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
  int _selectedCategory = 0;
  final Map<int, double> _ratingsByProductId = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<CategoryCubit>().fetchCategories();
        context.read<ProductCubit>().fetchProducts();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeHeaderWidget(),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, categoryState) {
            if (categoryState is CategoryLoading ||
                categoryState is CategoryInitial) {
              return const LoadingWidget(height: 50);
            }

            if (categoryState is CategoryError) {
              return Text(categoryState.message);
            }

            final categories = categoryState is CategoryLoaded
                ? _buildCategoryTitles(categoryState.categories)
                : <String>['الكل'];

            return Column(
              children: [
                HomeSearchSectionWidget(
                  title: context.l10n.getEverythingYouWant,
                  searchHint: context.l10n.searchHint,
                ),
                HeightSpace(30),
                HomeCategoriesWidget(
                  categories: categories,
                  selectedCategoryIndex: _selectedCategory,
                  onCategorySelected: (index) {
                    setState(() {
                      _selectedCategory = index;
                    });
                  },
                ),
                HeightSpace(30),
                Expanded(
                  child: BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, productState) {
                      if (productState is ProductLoading ||
                          productState is ProductInitial) {
                        return const LoadingWidget(height: 220);
                      }

                      if (productState is ProductError) {
                        return Text(productState.message);
                      }

                      final allProducts = productState is ProductLoaded
                          ? productState.products.items
                          : <ProductEntity>[];

                      final selectedCategoryName =
                          _selectedCategory == 0 ||
                              _selectedCategory >= categories.length
                          ? null
                          : categories[_selectedCategory];

                      final filteredProducts = selectedCategoryName == null
                          ? allProducts
                          : allProducts
                                .where(
                                  (product) =>
                                      product.categoryName
                                          .toLowerCase()
                                          .trim() ==
                                      selectedCategoryName.toLowerCase().trim(),
                                )
                                .toList();

                      if (filteredProducts.isEmpty) {
                        return const Center(
                          child: Text('لا توجد منتجات حالياً'),
                        );
                      }

                      final ratings = filteredProducts
                          .map(
                            (product) => _ratingsByProductId[product.id] ?? 3.5,
                          )
                          .toList();

                      return HomeRecommendedItemsListWidget(
                        products: filteredProducts,
                        ratings: ratings,
                        onRatingChanged: (itemIndex, rating) {
                          final product = filteredProducts[itemIndex];
                          setState(() {
                            _ratingsByProductId[product.id] = rating;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<String> _buildCategoryTitles(List<CategoryEntity> categories) {
    final titles = <String>['الكل'];
    if (categories.isEmpty) {
      return titles;
    }

    titles.addAll(categories.first.items.map((item) => item.name));
    return titles;
  }
}
