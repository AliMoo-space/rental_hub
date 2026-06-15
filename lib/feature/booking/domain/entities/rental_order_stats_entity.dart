class RentalOrderStatsEntity {
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

  factory RentalOrderStatsEntity.empty() => const RentalOrderStatsEntity(
        activeOrders: 0,
        pendingOrders: 0,
        completedOrders: 0,
        cancelledOrders: 0,
      );
}
