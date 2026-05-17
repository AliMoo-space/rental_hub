import 'package:rental_hub/feature/product_details/domain/entities/product_details_entity.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  ProductDetailsModel({
    required super.id,
    required super.name,
    required super.description,
    required super.condition,
    required super.status,
    required super.rejectionReason,
    required super.basePricePerDay,
    required super.finalPricePerDay,
    required super.commissionPercentage,
    required super.locationArea,
    required super.productType,
    required super.brand,
    required super.rentalGuarantee,
    required super.termsConditions,
    required super.createdAt,
    required super.updatedAt,
    required super.averageRating,
    required super.totalReviews,
    required super.totalRentalCount,
    required super.totalPlatformProfit,
    required super.ownerId,
    required super.ownerName,
    required super.ownerEmail,
    required super.ownerPhone,
    required super.categoryId,
    required super.categoryName,
    required super.subcategoryId,
    required super.subcategoryName,
    required super.images,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    final imagesValue = json['images'] as List? ?? const [];

    return ProductDetailsModel(
      id: _parseInt(json['id']),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      condition: json['condition']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      rejectionReason: json['rejectionReason']?.toString(),
      basePricePerDay: _parseDouble(json['basePricePerDay']),
      finalPricePerDay: _parseDouble(json['finalPricePerDay']),
      commissionPercentage: _parseDouble(json['commissionPercentage']),
      locationArea: json['locationArea']?.toString() ?? '',
      productType: json['productType']?.toString() ?? '',
      brand: json['brand']?.toString() ?? '',
      rentalGuarantee: json['rentalGuarantee']?.toString() ?? '',
      termsConditions: json['termsConditions']?.toString() ?? '',
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseNullableDateTime(json['updatedAt']),
      averageRating: _parseDouble(json['averageRating']),
      totalReviews: _parseInt(json['totalReviews']),
      totalRentalCount: _parseInt(json['totalRentalCount']),
      totalPlatformProfit: _parseDouble(json['totalPlatformProfit']),
      ownerId: json['ownerId']?.toString() ?? '',
      ownerName: json['ownerName']?.toString() ?? '',
      ownerEmail: json['ownerEmail']?.toString() ?? '',
      ownerPhone: json['ownerPhone']?.toString() ?? '',
      categoryId: _parseInt(json['categoryId']),
      categoryName: json['categoryName']?.toString() ?? '',
      subcategoryId: _parseInt(json['subcategoryId']),
      subcategoryName: json['subcategoryName']?.toString() ?? '',
      images: imagesValue.map((image) => image.toString()).toList(),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    final text = value?.toString();
    if (text == null || text.isEmpty) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.parse(text);
  }

  static DateTime? _parseNullableDateTime(dynamic value) {
    final text = value?.toString();
    if (text == null || text.isEmpty) return null;
    return DateTime.parse(text);
  }
}
