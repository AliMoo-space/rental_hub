import 'package:rental_hub/feature/search/domain/entities/search_result_entity.dart';

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
      return ProductItemEntity(
        id: map['id'] as int,
        name: map['name'] as String? ?? '',
        category: map['category'] as String? ?? '',
        basePricePerDay: (map['basePricePerDay'] as num?)?.toDouble() ?? 0.0,
        location: map['location'] as String? ?? '',
        condition: map['condition'] as String? ?? '',
        images: (map['images'] as List<dynamic>? ?? [])
            .map((img) => (img as Map<String, dynamic>)['url'] as String? ?? '')
            .toList(),
        rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      );
    }).toList();

    return SearchResultModel(
      items: items,
      totalCount: json['totalCount'] as int? ?? items.length,
      pageNumber: json['pageNumber'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? items.length,
    );
  }
}
