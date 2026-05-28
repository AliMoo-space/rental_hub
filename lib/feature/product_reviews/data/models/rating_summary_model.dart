import 'package:rental_hub/feature/product_reviews/domain/entities/rating_summary_entity.dart';

class RatingSummaryModel extends RatingSummaryEntity {
  const RatingSummaryModel({
    required super.averageRating,
    required super.totalReviews,
    required super.distribution,
  });

  factory RatingSummaryModel.fromJson(Map<String, dynamic> json) {
    final distributionJson = json['distribution'];
    final distribution = <int, int>{5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

    if (distributionJson is Map) {
      for (final star in distribution.keys) {
        final value =
            distributionJson[star.toString()] ?? distributionJson[star];
        distribution[star] = _parseInt(value);
      }
    }

    return RatingSummaryModel(
      averageRating: _parseDouble(json['averageRating']),
      totalReviews: _parseInt(json['totalReviews']),
      distribution: distribution,
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }
}
