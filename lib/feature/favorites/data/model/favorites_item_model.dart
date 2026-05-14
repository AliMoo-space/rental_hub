import 'package:rental_hub/feature/favorites/domain/entities/favorites_item_entity.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';

class FavoriteItemModel extends FavoriteItemEntity {
  const FavoriteItemModel({
    required super.id,
    required super.productId,
    required super.productName,
    required super.productImage,
    required super.finalPricePerDay,
    required super.averageRating,
    required super.createdAt,
  });

  factory FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    return FavoriteItemModel(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'] ?? '',
      productImage: json['productImage'] ?? '',
      finalPricePerDay: (json['finalPricePerDay'] as num).toDouble(),
      averageRating: (json['averageRating'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class FavoriteResponseModel {
  final List<FavoriteItemModel> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final int totalPages;

  FavoriteResponseModel({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
  });

  factory FavoriteResponseModel.fromJson(Map<String, dynamic> json) {
    return FavoriteResponseModel(
      items: (json['items'] as List)
          .map((e) => FavoriteItemModel.fromJson(e))
          .toList(),
      totalCount: json['totalCount'],
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
    );
  }
}

extension FavoriteItemMapper on FavoriteItemModel {
  ProductEntity toProductEntity() {
    return ProductEntity(
      id: productId,
      userId: '',
      userFullName: '',
      categoryId: 0,
      categoryName: '',
      subcategoryId: 0,
      subcategoryName: '',
      locationArea: '',
      condition: '',
      productType: '',
      brand: '',
      rentalGuarantee: '',
      name: productName,
      description: '',
      basePricePerDay: 0,
      finalPricePerDay: finalPricePerDay,
      commissionPercentage: 0,
      termsConditions: '',
      status: '',
      createdAt: DateTime.now(),
      averageRating: averageRating,
      totalReviews: 0,
      totalRentalCount: 0,
      totalPlatformProfit: 0,
      images: [],
      isFavorite: true,
    );
  }
}
