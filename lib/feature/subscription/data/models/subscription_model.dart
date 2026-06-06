import 'package:rental_hub/feature/subscription/domain/entities/subscription_entity.dart';

class SubscriptionPlanModel extends SubscriptionPlanEntity {
  const SubscriptionPlanModel({
    required super.id,
    required super.name,
    required super.price,
    required super.durationDays,
    required super.maxProducts,
    required super.features,
    required super.createdAt,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      durationDays: json['durationDays'] ?? 0,
      maxProducts: json['maxProducts'] ?? 0,
      features: (json['features'] as List<dynamic>? ?? [])
          .map((feature) => feature.toString())
          .toList(growable: false),
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}

class SubscriptionResponseModel extends SubscriptionResponseEntity {
  const SubscriptionResponseModel({
    required super.items,
    required super.totalCount,
    required super.pageNumber,
    required super.pageSize,
    required super.totalPages,
    required super.hasPrevious,
    required super.hasNext,
  });

  factory SubscriptionResponseModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponseModel(
      items: (json['items'] as List<dynamic>? ?? [])
          .map(
            (item) => SubscriptionPlanModel.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(growable: false),
      totalCount: json['totalCount'] ?? 0,
      pageNumber: json['pageNumber'] ?? 1,
      pageSize: json['pageSize'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      hasPrevious: json['hasPrevious'] ?? false,
      hasNext: json['hasNext'] ?? false,
    );
  }
}

class SubscriptionActionResultModel extends SubscriptionActionResultEntity {
  const SubscriptionActionResultModel({required super.message});

  factory SubscriptionActionResultModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionActionResultModel(
      message: json['message']?.toString() ?? 'Success',
    );
  }
}

class SubscriptionActiveModel extends SubscriptionActiveEntity {
  const SubscriptionActiveModel({required super.hasActiveSubscription});

  factory SubscriptionActiveModel.fromJson(Map<String, dynamic> json) {
    final active = _extractActiveFlag(json);
    return SubscriptionActiveModel(hasActiveSubscription: active);
  }

  static bool _extractActiveFlag(Map<String, dynamic> json) {
    final candidates = <dynamic>[
      json['hasActiveSubscription'],
      json['isActive'],
      json['active'],
      json['isSubscribed'],
      json['subscriptionActive'],
      json['hasSubscription'],
      json['data'],
      json['subscription'],
    ];

    for (final candidate in candidates) {
      final parsed = _parseBoolCandidate(candidate);
      if (parsed != null) {
        return parsed;
      }
    }

    return false;
  }

  static bool? _parseBoolCandidate(dynamic value) {
    if (value is bool) return value;

    if (value is num) {
      if (value == 1) return true;
      if (value == 0) return false;
    }

    if (value is String) {
      final normalized = value.trim().toLowerCase();
      if (normalized.isEmpty) return null;
      if (const {
        'true',
        '1',
        'yes',
        'active',
        'subscribed',
      }.contains(normalized)) {
        return true;
      }
      if (const {
        'false',
        '0',
        'no',
        'inactive',
        'unsubscribed',
      }.contains(normalized)) {
        return false;
      }
      return null;
    }

    if (value is Map) {
      final map = Map<String, dynamic>.from(value);
      final nested = _extractActiveFlag(map);
      if (nested) {
        return true;
      }

      for (final key in const [
        'hasActiveSubscription',
        'isActive',
        'active',
        'isSubscribed',
        'subscriptionActive',
        'status',
        'state',
        'subscriptionStatus',
      ]) {
        final nestedCandidate = _parseBoolCandidate(map[key]);
        if (nestedCandidate != null) {
          return nestedCandidate;
        }
      }
    }

    return null;
  }
}
