import 'package:rental_hub/feature/my_products/domain/entities/product_stats_entity.dart';

class ProductStatsModel extends ProductStatsEntity {
  const ProductStatsModel({
    required super.rentalsCount,
    required super.earnings,
    required super.averageRating,
  });

  factory ProductStatsModel.fromJson(Map<String, dynamic> json) {
    return ProductStatsModel(
      rentalsCount: _parseInt(
        json['rentalsCount'] ??
            json['rentalCount'] ??
            json['totalRentals'] ??
            json['rentals'] ??
            json['count'],
      ),
      earnings: _parseDouble(
        json['earnings'] ??
            json['totalEarnings'] ??
            json['revenue'] ??
            json['totalRevenue'] ??
            json['totalPlatformProfit'],
      ),
      averageRating: _parseDouble(
        json['averageRating'] ??
            json['avgRating'] ??
            json['rating'] ??
            json['average_rating'],
      ),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0.0;
  }
}
