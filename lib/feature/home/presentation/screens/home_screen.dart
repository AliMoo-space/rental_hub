import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
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
import 'package:rental_hub/feature/home/presentation/widgets/subscription_banner_widget.dart';

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
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CategoryCubit>().fetchCategories();
          context.read<ProductCubit>().refresh();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeSearchSectionWidget(
                  title: context.l10n.getEverythingYouWant,
                  searchHint: context.l10n.searchHint,
                ),
                HeightSpace(20),
                const SubscriptionBannerWidget(),
                HeightSpace(20),
                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, categoryState) {
                    if (categoryState is CategoryLoading ||
                        categoryState is CategoryInitial) {
                      return const LoadingWidget(height: 50);
                    }

                    if (categoryState is CategoryError) {
                      return SizedBox(
                        height: 50.h,
                        child: Center(
                          child: Text(
                            categoryState.message,
                            style: AppStyles.instrumentSans500Size14.copyWith(
                              color: AppColors.errorColor,
                            ),
                          ),
                        ),
                      );
                    }

                    final categories = categoryState is CategoryLoaded
                        ? _buildCategoryTitles(categoryState.categories)
                        : <String>['All'];

                    return HomeCategoriesWidget(
                      categories: categories,
                      selectedCategoryIndex: _selectedCategory,
                      onCategorySelected: (index) {
                        setState(() {
                          _selectedCategory = index;
                        });
                      },
                    );
                  },
                ),
                HeightSpace(20),
                SizedBox(
                  height: 500.h,
                  child: BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, productState) {
                      final categoryState = context.read<CategoryCubit>().state;
                      final categories = categoryState is CategoryLoaded
                          ? _buildCategoryTitles(categoryState.categories)
                          : <String>['All'];

                      final selectedCategoryName =
                          _selectedCategory == 0 ||
                              _selectedCategory >= categories.length
                          ? null
                          : categories[_selectedCategory];

                      if (selectedCategoryName == null) {
                        return HomeRecommendedItemsListWidget(
                          ratings: const [],
                          pagingController: context
                              .read<ProductCubit>()
                              .pagingController,
                          onFavoritePressed: (product) {
                            context.read<ProductCubit>().toggleFavorite(
                              product.id,
                            );
                          },
                          isFavoriteLoading: (product) {
                            final state = context.read<ProductCubit>().state;
                            return state is ProductLoaded &&
                                state.isFavoriteLoading(product.id);
                          },
                          onRatingChanged: (product, _, rating) {
                            if (product == null) return;
                            setState(() {
                              _ratingsByProductId[product.id] = rating;
                            });
                          },
                        );
                      }

                      if (productState is ProductLoading ||
                          productState is ProductInitial) {
                        return const LoadingWidget(height: 220);
                      }

                      if (productState is ProductError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                productState.message,
                                textAlign: TextAlign.center,
                              ),
                              TextButton(
                                onPressed: () =>
                                    context.read<ProductCubit>().refresh(),
                                child: const Text('إعادة المحاولة'),
                              ),
                            ],
                          ),
                        );
                      }

                      final allProducts = productState is ProductLoaded
                          ? productState.products.items
                          : <ProductEntity>[];

                      final filteredProducts = allProducts
                          .where(
                            (product) =>
                                product.categoryName.toLowerCase().trim() ==
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
                        onFavoritePressed: (product) {
                          context.read<ProductCubit>().toggleFavorite(
                            product.id,
                          );
                        },
                        isFavoriteLoading: (product) {
                          final state = context.read<ProductCubit>().state;
                          return state is ProductLoaded &&
                              state.isFavoriteLoading(product.id);
                        },
                        onRatingChanged: (product, itemIndex, rating) {
                          final selectedProduct =
                              product ?? filteredProducts[itemIndex];
                          setState(() {
                            _ratingsByProductId[selectedProduct.id] = rating;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> _buildCategoryTitles(List<CategoryEntity> categories) {
    return [
      'All',
      ...categories.expand(
        (category) => category.items.map((item) => item.name),
      ),
    ];
  }
}
