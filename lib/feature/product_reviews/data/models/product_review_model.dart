import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/product_review_entity.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/product_review_page_entity.dart';

class ProductReviewModel extends ProductReviewEntity {
  const ProductReviewModel({
    required super.id,
    required super.userId,
    required super.userName,
    required super.userImage,
    required super.score,
    required super.comment,
    required super.createdAt,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewModel(
      id: _parseInt(json['id']),
      userId: json['userId']?.toString() ?? '',
      userName: json['userName']?.toString() ?? '',
      userImage: _normalizeImageUrl(json['userImage']?.toString()),
      score: _parseInt(json['score']),
      comment: json['comment']?.toString(),
      createdAt: _parseDateTime(json['createdAt']),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) {
      return DateTime.now();
    }
    return DateTime.tryParse(value.toString()) ?? DateTime.now();
  }

  static String? _normalizeImageUrl(String? value) {
    final image = value?.trim();
    if (image == null || image.isEmpty) {
      return null;
    }
    if (image.startsWith('http')) {
      return image;
    }
    if (image.startsWith('/')) {
      return '${EndPoints.baseUrl}$image';
    }
    return '${EndPoints.baseUrl}/$image';
  }
}

class ProductReviewPageModel {
  final List<ProductReviewModel> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  const ProductReviewPageModel({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });

  factory ProductReviewPageModel.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'] as List? ?? const [];

    return ProductReviewPageModel(
      items: itemsJson
          .whereType<Map>()
          .map(
            (item) =>
                ProductReviewModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList(),
      totalCount: _parseInt(json['totalCount']),
      pageNumber: _parseInt(json['pageNumber']),
      pageSize: _parseInt(json['pageSize']),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  ProductReviewPageEntity toEntity() {
    return ProductReviewPageEntity(
      items: items,
      totalCount: totalCount,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
