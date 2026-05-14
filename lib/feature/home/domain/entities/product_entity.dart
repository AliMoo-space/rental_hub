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

  ProductsEntity copyWith({
    List<ProductEntity>? items,
    int? totalCount,
    int? pageNumber,
    int? pageSize,
    int? totalPages,
    bool? hasPrevious,
    bool? hasNext,
  }) {
    return ProductsEntity(
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      totalPages: totalPages ?? this.totalPages,
      hasPrevious: hasPrevious ?? this.hasPrevious,
      hasNext: hasNext ?? this.hasNext,
    );
  }
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
  final bool isFavorite;

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
    this.isFavorite = false,
  });

  ProductEntity copyWith({
    int? id,
    String? userId,
    String? userFullName,
    int? categoryId,
    String? categoryName,
    int? subcategoryId,
    String? subcategoryName,
    String? locationArea,
    String? condition,
    String? productType,
    String? brand,
    String? rentalGuarantee,
    String? name,
    String? description,
    num? basePricePerDay,
    num? finalPricePerDay,
    num? commissionPercentage,
    String? termsConditions,
    String? status,
    DateTime? createdAt,
    double? averageRating,
    int? totalReviews,
    int? totalRentalCount,
    num? totalPlatformProfit,
    List<String>? images,
    bool? isFavorite,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userFullName: userFullName ?? this.userFullName,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      subcategoryName: subcategoryName ?? this.subcategoryName,
      locationArea: locationArea ?? this.locationArea,
      condition: condition ?? this.condition,
      productType: productType ?? this.productType,
      brand: brand ?? this.brand,
      rentalGuarantee: rentalGuarantee ?? this.rentalGuarantee,
      name: name ?? this.name,
      description: description ?? this.description,
      basePricePerDay: basePricePerDay ?? this.basePricePerDay,
      finalPricePerDay: finalPricePerDay ?? this.finalPricePerDay,
      commissionPercentage: commissionPercentage ?? this.commissionPercentage,
      termsConditions: termsConditions ?? this.termsConditions,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
      totalRentalCount: totalRentalCount ?? this.totalRentalCount,
      totalPlatformProfit: totalPlatformProfit ?? this.totalPlatformProfit,
      images: images ?? this.images,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
