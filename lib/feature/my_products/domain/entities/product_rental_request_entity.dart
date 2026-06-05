class ProductRentalRequestEntity {
  final int id;
  final String renterName;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final double totalPrice;

  const ProductRentalRequestEntity({
    required this.id,
    required this.renterName,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.totalPrice,
  });
}
