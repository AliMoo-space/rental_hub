class FavoriteItemEntity {
  final int id;
  final int productId;
  final String productName;
  final String productImage;
  final double finalPricePerDay;
  final double averageRating;
  final DateTime createdAt;

  const FavoriteItemEntity({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.finalPricePerDay,
    required this.averageRating,
    required this.createdAt,
  });
}
