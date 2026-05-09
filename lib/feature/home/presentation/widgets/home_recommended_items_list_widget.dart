import 'package:flutter/material.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_recommended_item_card_widget.dart';

class HomeRecommendedItemsListWidget extends StatelessWidget {
  const HomeRecommendedItemsListWidget({
    super.key,
    required this.ratings,
    required this.onRatingChanged,
    this.products,
    this.shrinkWrap = false,
    this.physics,
  });

  final List<double> ratings;
  final void Function(int itemIndex, double rating) onRatingChanged;
  final List<ProductEntity>? products;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: products?.length ?? ratings.length,
      itemBuilder: (context, index) {
        final product = products?[index];
        final rating = index < ratings.length ? ratings[index] : 3.5;
        return HomeRecommendedItemCardWidget(
          rating: rating,
          product: product,
          onRatingChanged: (rating) => onRatingChanged(index, rating),
        );
      },
    );
  }
}
