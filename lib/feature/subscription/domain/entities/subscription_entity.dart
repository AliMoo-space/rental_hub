class SubscriptionPlanEntity {
  final int id;
  final String name;
  final double price;
  final int durationDays;
  final int maxProducts;
  final List<String> features;
  final DateTime createdAt;

  const SubscriptionPlanEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.durationDays,
    required this.maxProducts,
    required this.features,
    required this.createdAt,
  });
}

class SubscriptionResponseEntity {
  final List<SubscriptionPlanEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final bool hasPrevious;
  final bool hasNext;

  const SubscriptionResponseEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.hasPrevious,
    required this.hasNext,
  });
}

class SubscriptionActionResultEntity {
  final String message;

  const SubscriptionActionResultEntity({required this.message});
}

class SubscriptionActiveEntity {
  final bool hasActiveSubscription;

  const SubscriptionActiveEntity({required this.hasActiveSubscription});
}
