import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_recommended_item_card_widget.dart';
import 'dart:developer' as developer;

class HomeRecommendedItemsListWidget extends StatelessWidget {
  const HomeRecommendedItemsListWidget({
    super.key,
    required this.ratings,
    required this.onRatingChanged,
    this.onFavoritePressed,
    this.isFavoriteLoading,
    this.products,
    this.pagingController,
    this.shrinkWrap = false,
    this.physics,
  });

  final List<double> ratings;
  final void Function(ProductEntity? product, int itemIndex, double rating)
  onRatingChanged;
  final void Function(ProductEntity product)? onFavoritePressed;
  final bool Function(ProductEntity product)? isFavoriteLoading;
  final List<ProductEntity>? products;
  final PagingController<int, ProductEntity>? pagingController;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    // Use PagedListView if pagingController is provided
    if (pagingController != null) {
      return ValueListenableBuilder<PagingState<int, ProductEntity>>(
        valueListenable: pagingController!,
        builder: (context, state, _) {
          return PagedListView<int, ProductEntity>(
            state: state,

            fetchNextPage: () => pagingController!.fetchNextPage(),
            builderDelegate: PagedChildBuilderDelegate<ProductEntity>(
              itemBuilder: (context, item, index) {
                developer.log('itemBuilder count: Index $index, Item: ${item.id}', name: 'Instrumentation');
                final rating = index < ratings.length ? ratings[index] : 3.5;
                return HomeRecommendedItemCardWidget(
                  rating: rating,
                  product: item,
                  onTap: () => context.pushNamed(
                    AppRoutes.productDetailsScreen,
                    pathParameters: AppRoutes.productDetailsPathParameters(
                      item.id,
                    ),
                    extra: item,
                  ),
                  onRatingChanged: (rating) =>
                      onRatingChanged(item, index, rating),
                  onFavoritePressed: onFavoritePressed == null
                      ? null
                      : () => onFavoritePressed!(item),
                  isFavoriteLoading: isFavoriteLoading?.call(item) ?? false,
                );
              },
              firstPageErrorIndicatorBuilder: (context) =>
                  const Center(child: Text('خطأ في تحميل المنتجات')),
              noItemsFoundIndicatorBuilder: (context) =>
                  const Center(child: Text('لا توجد منتجات')),
            ),
            physics: physics,
            shrinkWrap: shrinkWrap,
          );
        },
      );
    }

    // Fallback to regular ListView
    return ListView.builder(
      shrinkWrap: shrinkWrap,

      physics: NeverScrollableScrollPhysics(),
      itemCount: products?.length ?? ratings.length,
      itemBuilder: (context, index) {
        final product = products?[index];
        final rating = index < ratings.length ? ratings[index] : 3.5;
        final detailsTap = product == null
            ? null
            : () => context.pushNamed(
                AppRoutes.productDetailsScreen,
                pathParameters: AppRoutes.productDetailsPathParameters(
                  product.id,
                ),
                extra: product,
              );
        return HomeRecommendedItemCardWidget(
          rating: rating,
          product: product,
          onTap: detailsTap,
          onRatingChanged: (rating) => onRatingChanged(product, index, rating),
          onFavoritePressed: product == null || onFavoritePressed == null
              ? null
              : () => onFavoritePressed!(product),
          isFavoriteLoading: product == null
              ? false
              : isFavoriteLoading?.call(product) ?? false,
        );
      },
    );
  }
}
