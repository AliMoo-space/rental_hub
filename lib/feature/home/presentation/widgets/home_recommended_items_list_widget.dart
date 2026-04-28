import 'package:flutter/material.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_recommended_item_card_widget.dart';

class HomeRecommendedItemsListWidget extends StatelessWidget {
  const HomeRecommendedItemsListWidget({
    super.key,
    required this.ratings,
    required this.onRatingChanged,
    this.shrinkWrap = false,
    this.physics,
  });

  final List<double> ratings;
  final void Function(int itemIndex, double rating) onRatingChanged;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: ratings.length,
      itemBuilder: (context, index) {
        return HomeRecommendedItemCardWidget(
          rating: ratings[index],
          onRatingChanged: (rating) => onRatingChanged(index, rating),
        );
      },
    );
  }
}
