class ProductItemEntity {
  final int id;
  final String name;
  final String category;
  final double basePricePerDay;
  final String location;
  final String condition;
  final List<String> images;
  final double rating;

  ProductItemEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.basePricePerDay,
    required this.location,
    required this.condition,
    required this.images,
    required this.rating,
  });
}

class SearchResultEntity {
  final List<ProductItemEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  SearchResultEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });
}
