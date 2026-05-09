class CategoryEntity {
  final List<SubCategoryEntity> items;

  CategoryEntity({required this.items});
}

class SubCategoryEntity {
  final int id;
  final String name;
  final DateTime createdAt;

  SubCategoryEntity({
    required this.id,
    required this.name,
    required this.createdAt,
  });
}
