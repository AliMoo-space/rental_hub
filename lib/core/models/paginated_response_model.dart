class PaginatedResponseModel<T> {
  final List<T> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final bool hasPrevious;
  final bool hasNext;

  const PaginatedResponseModel({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.hasPrevious,
    required this.hasNext,
  });

  factory PaginatedResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) itemParser,
  ) {
    final itemsValue = json['items'] as List? ?? const [];
    final parsedItems = itemsValue
        .whereType<Map>()
        .map((item) => itemParser(Map<String, dynamic>.from(item)))
        .toList();

    return PaginatedResponseModel<T>(
      items: parsedItems,
      totalCount: _parseInt(json['totalCount']),
      pageNumber: _parseInt(json['pageNumber']),
      pageSize: _parseInt(json['pageSize']),
      totalPages: _parseInt(json['totalPages']),
      hasPrevious: json['hasPrevious'] == true,
      hasNext: json['hasNext'] == true,
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
