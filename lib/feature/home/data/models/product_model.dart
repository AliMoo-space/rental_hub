import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';

class ProductsModel extends ProductsEntity {
  ProductsModel({
    required super.items,
    required super.totalCount,
    required super.pageNumber,
    required super.pageSize,
    required super.totalPages,
    required super.hasPrevious,
    required super.hasNext,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List? ?? [];
    return ProductsModel(
      items: itemsList
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalCount: _parseInt(json['totalCount']),
      pageNumber: _parseInt(json['pageNumber']),
      pageSize: _parseInt(json['pageSize']),
      totalPages: _parseInt(json['totalPages']),
      hasPrevious: _parseBool(json['hasPrevious']),
      hasNext: _parseBool(json['hasNext']),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    final normalized = value.toString().toLowerCase();
    return normalized == 'true' || normalized == '1';
  }
}

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.userId,
    required super.userFullName,
    required super.categoryId,
    required super.categoryName,
    required super.subcategoryId,
    required super.subcategoryName,
    required super.locationArea,
    required super.condition,
    required super.productType,
    required super.brand,
    required super.rentalGuarantee,
    required super.name,
    required super.description,
    required super.basePricePerDay,
    required super.finalPricePerDay,
    required super.commissionPercentage,
    required super.termsConditions,
    required super.status,
    required super.createdAt,
    required super.averageRating,
    required super.totalReviews,
    required super.totalRentalCount,
    required super.totalPlatformProfit,
    required super.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final createdAtValue = json['createdAt'] ?? json['created_at'];
    final imagesValue = json['images'] as List? ?? const [];

    return ProductModel(
      id: _parseInt(json['id']),
      userId: json['userId']?.toString() ?? '',
      userFullName: json['userFullName']?.toString() ?? '',
      categoryId: _parseInt(json['categoryId']),
      categoryName: json['categoryName']?.toString() ?? '',
      subcategoryId: _parseInt(json['subcategoryId']),
      subcategoryName: json['subcategoryName']?.toString() ?? '',
      locationArea: json['locationArea']?.toString() ?? '',
      condition: json['condition']?.toString() ?? '',
      productType: json['productType']?.toString() ?? '',
      brand: json['brand']?.toString() ?? '',
      rentalGuarantee: json['rentalGuarantee']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      basePricePerDay: _parseNum(json['basePricePerDay']),
      finalPricePerDay: _parseNum(json['finalPricePerDay']),
      commissionPercentage: _parseNum(json['commissionPercentage']),
      termsConditions: json['termsConditions']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: DateTime.parse(createdAtValue.toString()),
      averageRating: _parseDouble(json['averageRating']),
      totalReviews: _parseInt(json['totalReviews']),
      totalRentalCount: _parseInt(json['totalRentalCount']),
      totalPlatformProfit: _parseNum(json['totalPlatformProfit']),
      images: imagesValue.map((image) => image.toString()).toList(),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  static num _parseNum(dynamic value) {
    if (value is num) return value;
    return num.tryParse(value.toString()) ?? 0;
  }
}
