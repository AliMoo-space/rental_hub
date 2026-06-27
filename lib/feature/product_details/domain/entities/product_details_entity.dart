class ProductDetailsEntity {
  final int id;
  final String name;
  final String description;
  final String condition;
  final String status;
  final String? rejectionReason;
  final double basePricePerDay;
  final double finalPricePerDay;
  final double commissionPercentage;
  final String locationArea;
  final String productType;
  final String brand;
  final String rentalGuarantee;
  final String termsConditions;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final double averageRating;
  final int totalReviews;
  final int totalRentalCount;
  final double totalPlatformProfit;
  final String ownerId;
  final String ownerName;
  final String ownerEmail;
  final String ownerPhone;
  final int categoryId;
  final String categoryName;
  final int subcategoryId;
  final String subcategoryName;
  final List<String> images;
  final bool isFavorite;

  ProductDetailsEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.condition,
    required this.status,
    required this.rejectionReason,
    required this.basePricePerDay,
    required this.finalPricePerDay,
    required this.commissionPercentage,
    required this.locationArea,
    required this.productType,
    required this.brand,
    required this.rentalGuarantee,
    required this.termsConditions,
    required this.createdAt,
    required this.updatedAt,
    required this.averageRating,
    required this.totalReviews,
    required this.totalRentalCount,
    required this.totalPlatformProfit,
    required this.ownerId,
    required this.ownerName,
    required this.ownerEmail,
    required this.ownerPhone,
    required this.categoryId,
    required this.categoryName,
    required this.subcategoryId,
    required this.subcategoryName,
    required this.images,
    this.isFavorite = false,
  });
}
