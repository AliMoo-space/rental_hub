import 'package:rental_hub/feature/my_products/domain/entities/owner_stats_entity.dart';

class OwnerStatsModel extends OwnerStatsEntity {
  const OwnerStatsModel({
    required super.totalProducts,
    required super.activeProducts,
    required super.suspendedProducts,
    required super.totalRentals,
    required super.totalEarnings,
  });

  factory OwnerStatsModel.fromJson(Map<String, dynamic> json) {
    return OwnerStatsModel(
      totalProducts: _parseInt(json['totalProducts'] ?? json['total_products'] ?? json['productsCount']),
      activeProducts: _parseInt(json['activeProducts'] ?? json['active_products'] ?? json['activeCount']),
      suspendedProducts: _parseInt(json['suspendedProducts'] ?? json['suspended_products'] ?? json['suspendedCount']),
      totalRentals: _parseInt(json['totalRentals'] ?? json['total_rentals'] ?? json['rentalsCount']),
      totalEarnings: _parseDouble(json['totalEarnings'] ?? json['total_earnings'] ?? json['earnings'] ?? json['totalRevenue']),
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
