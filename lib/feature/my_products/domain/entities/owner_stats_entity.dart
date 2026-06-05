class OwnerStatsEntity {
  final int totalProducts;
  final int activeProducts;
  final int suspendedProducts;
  final int totalRentals;
  final double totalEarnings;

  const OwnerStatsEntity({
    required this.totalProducts,
    required this.activeProducts,
    required this.suspendedProducts,
    required this.totalRentals,
    required this.totalEarnings,
  });
}
