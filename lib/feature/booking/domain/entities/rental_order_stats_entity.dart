import 'package:equatable/equatable.dart';

class RentalOrderStatsEntity extends Equatable {
  final int activeOrders;
  final int pendingOrders;
  final int completedOrders;
  final int cancelledOrders;

  const RentalOrderStatsEntity({
    required this.activeOrders,
    required this.pendingOrders,
    required this.completedOrders,
    required this.cancelledOrders,
  });

  @override
  List<Object?> get props => [
    activeOrders,
    pendingOrders,
    completedOrders,
    cancelledOrders,
  ];

  factory RentalOrderStatsEntity.empty() => const RentalOrderStatsEntity(
    activeOrders: 0,
    pendingOrders: 0,
    completedOrders: 0,
    cancelledOrders: 0,
  );
}
