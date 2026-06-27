import 'package:rental_hub/feature/search/domain/entities/search_result_entity.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';

class SearchResultModel extends SearchResultEntity {
  SearchResultModel({
    required super.items,
    required super.totalCount,
    required super.pageNumber,
    required super.pageSize,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>? ?? []).map((e) {
      final map = e as Map<String, dynamic>;
      final createdAtValue = map['createdAt'] ?? map['created_at'];
      return ProductItemEntity(
        id: map['id'] as int,
        name: map['name'] as String? ?? '',
        category: map['category'] as String? ?? '',
        basePricePerDay: (map['basePricePerDay'] as num?)?.toDouble() ?? 0.0,
        location: map['location'] as String? ?? '',
        condition: map['condition'] as String? ?? '',
        images: (map['images'] as List<dynamic>? ?? [])
            .map((img) {
              if (img == null) return '';
              String url = '';
              if (img is String) {
                url = img;
              } else if (img is Map) {
                url =
                    img['imageUrl']?.toString() ?? img['url']?.toString() ?? '';
              }
              if (url.isEmpty || url.toLowerCase() == 'null') return '';
              if (url.startsWith('http://') || url.startsWith('https://'))
                return url;
              if (!url.startsWith('/')) url = '/$url';
              return '${EndPoints.baseUrl}$url';
            })
            .where((s) => s.isNotEmpty)
            .toList(),
        rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
        createdAt:
            DateTime.tryParse(createdAtValue?.toString() ?? '') ??
            DateTime.now(),
      );
    }).toList();

    return SearchResultModel(
      items: items,
      totalCount: json['totalCount'] as int? ?? items.length,
      pageNumber: json['pageNumber'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? items.length,
    );
  }

  factory SearchResultModel.fromRecommendationsJson(Map<String, dynamic> json) {
    final products = (json['products'] as List<dynamic>? ?? []).map((e) {
      final map = e as Map<String, dynamic>;
      final imageUrl = map['image_url'] as String? ?? '';
      return ProductItemEntity(
        id: map['id'] as int,
        name: map['name'] as String? ?? '',
        category: map['category'] as String? ?? '',
        basePricePerDay: (map['price_per_day'] as num?)?.toDouble() ?? 0.0,
        location: map['location'] as String? ?? '',
        condition: map['condition'] as String? ?? '',
        images: imageUrl.isNotEmpty ? [imageUrl] : const [],
        rating: 0.0,
        createdAt: DateTime.tryParse(map['created_at']?.toString() ?? ''),
      );
    }).toList();

    return SearchResultModel(
      items: products,
      totalCount: products.length,
      pageNumber: 1,
      pageSize: products.length,
    );
  }
}
