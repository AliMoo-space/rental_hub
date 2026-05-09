class ProductsEntity {
  final List<ProductEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final bool hasPrevious;
  final bool hasNext;

  ProductsEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.hasPrevious,
    required this.hasNext,
  });
}

class ProductEntity {
  final int id;
  final String userId;
  final String userFullName;
  final int categoryId;
  final String categoryName;
  final int subcategoryId;
  final String subcategoryName;
  final String locationArea;
  final String condition;
  final String productType;
  final String brand;
  final String rentalGuarantee;
  final String name;
  final String description;
  final num basePricePerDay;
  final num finalPricePerDay;
  final num commissionPercentage;
  final String termsConditions;
  final String status;
  final DateTime createdAt;
  final double averageRating;
  final int totalReviews;
  final int totalRentalCount;
  final num totalPlatformProfit;
  final List<String> images;

  ProductEntity({
    required this.id,
    required this.userId,
    required this.userFullName,
    required this.categoryId,
    required this.categoryName,
    required this.subcategoryId,
    required this.subcategoryName,
    required this.locationArea,
    required this.condition,
    required this.productType,
    required this.brand,
    required this.rentalGuarantee,
    required this.name,
    required this.description,
    required this.basePricePerDay,
    required this.finalPricePerDay,
    required this.commissionPercentage,
    required this.termsConditions,
    required this.status,
    required this.createdAt,
    required this.averageRating,
    required this.totalReviews,
    required this.totalRentalCount,
    required this.totalPlatformProfit,
    required this.images,
  });
}
