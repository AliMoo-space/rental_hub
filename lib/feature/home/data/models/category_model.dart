import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.items});
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List? ?? [];
    final items = itemsList
        .map((item) => SubCategoryModel.fromJson(item as Map<String, dynamic>))
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
        DateTime.tryParse(createdAtStr?.toString() ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0);

    return SubCategoryModel(
      id: id is int ? id : int.parse(id.toString()),
      name: name.toString(),
      createdAt: parsedCreatedAt,
    );
  }
}
