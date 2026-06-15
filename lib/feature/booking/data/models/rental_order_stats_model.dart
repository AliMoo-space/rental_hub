import 'package:rental_hub/feature/booking/domain/entities/rental_order_stats_entity.dart';

class RentalOrderStatsModel extends RentalOrderStatsEntity {
  const RentalOrderStatsModel({
    required super.activeOrders,
    required super.pendingOrders,
    required super.completedOrders,
    required super.cancelledOrders,
  });

  factory RentalOrderStatsModel.fromJson(Map<String, dynamic> json) {
    return RentalOrderStatsModel(
      activeOrders: json['activeOrders'] ?? 0,
      pendingOrders: json['pendingOrders'] ?? 0,
      completedOrders: json['completedOrders'] ?? 0,
      cancelledOrders: json['cancelledOrders'] ?? 0,
    );
  }
}
