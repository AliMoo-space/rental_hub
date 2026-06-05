class ProductTransactionEntity {
  final int id;
  final String renterName;
  final DateTime startDate;
  final DateTime endDate;
  final double totalPrice;
  final String status;

  const ProductTransactionEntity({
    required this.id,
    required this.renterName,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
  });
}
