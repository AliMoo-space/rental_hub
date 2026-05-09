import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.items});
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    print('Parsing CategoryModel from JSON: $json');
    try {
      final itemsList = json['items'] as List? ?? [];
      final items = itemsList
          .map((item) => SubCategoryModel.fromJson(item as Map<String, dynamic>))
          .toList();
      print('Parsed ${items.length} categories');
      return CategoryModel(items: items);
    } catch (e) {
      print('Error parsing CategoryModel: $e');
      rethrow;
    }
  }
}

class SubCategoryModel extends SubCategoryEntity {
  SubCategoryModel({
    required super.id,
    required super.name,
    required super.createdAt,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    try {
      final id = json['id'];
      final name = json['name'];
      // تعامل مع كلا الصيغتين: createdAt و created_at
      final createdAtStr = json['createdAt'] ?? json['created_at'];
      
      return SubCategoryModel(
        id: id is int ? id : int.parse(id.toString()),
        name: name.toString(),
        createdAt: DateTime.parse(createdAtStr.toString()),
      );
    } catch (e) {
      print('Error parsing SubCategoryModel: $e, JSON: $json');
      rethrow;
    }
  }
}
