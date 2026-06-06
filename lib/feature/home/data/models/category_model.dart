import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.items});

  factory CategoryModel.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      // If the API returns a List directly, or malformed data
      if (json is List) {
        final items = json
            .whereType<Map<String, dynamic>>()
            .map(SubCategoryModel.fromJson)
            .toList();
        return CategoryModel(items: items);
      }
      return CategoryModel(items: []);
    }

    final itemsList = json['items'] as List? ?? [];
    final items = itemsList
        .whereType<Map<String, dynamic>>()
        .map(SubCategoryModel.fromJson)
        .toList();

    return CategoryModel(items: items);
  }
}

class SubCategoryModel extends SubCategoryEntity {
  SubCategoryModel({
    required super.id,
    required super.name,
    required super.createdAt,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final createdAtStr = json['createdAt'] ?? json['created_at'];
    final parsedCreatedAt =
        DateTime.tryParse(createdAtStr?.toString() ?? '') ?? DateTime.now();

    return SubCategoryModel(
      id: _parseInt(id),
      name: name?.toString() ?? '',
      createdAt: parsedCreatedAt,
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value == null) return 0;
    return int.tryParse(value.toString()) ?? 0;
  }
}
