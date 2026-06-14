import 'package:rental_hub/feature/ai_chat/domain/entities/ai_chat_entity.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';

class AiChatModel extends AiChatEntity {
  AiChatModel({
    required super.answer,
    required super.intent,
    required super.products,
    required super.totalFound,
    required super.latencyMs,
    required super.cached,
  });
  factory AiChatModel.fromJson(Map<String, dynamic> json) {
    return AiChatModel(
      answer: json['answer'] ?? '',
      intent: json['intent'] ?? '',
      products: (json['products'] as List<dynamic>? ?? [])
          .map((e) => ProductChatModel.fromJson(e))
          .toList(),
      totalFound: json['total_found'] ?? 0,
      latencyMs: json['latency_ms'] ?? 0,
      cached: json['cached'] ?? false,
    );
  }
}

class ProductChatModel extends ProductChatEntity {
  ProductChatModel({
    required super.id,
    required super.name,
    required super.category,
    required super.brand,
    required super.condition,
    required super.pricePerDay,
    required super.location,
    required super.rentalGuarantee,
    required super.status,
    super.imageUrl,
  });

  factory ProductChatModel.fromJson(Map<String, dynamic> json) {
    return ProductChatModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      brand: json['brand'] ?? '',
      condition: json['condition'] ?? '',
      pricePerDay: (json['price_per_day'] as num?)?.toDouble() ?? 0.0,
      location: json['location'] ?? '',
      rentalGuarantee: json['rental_guarantee'] ?? false,
      status: json['status'] ?? '',
      imageUrl: _parseImageUrl(json['image_url']),
    );
  }

  static String? _parseImageUrl(dynamic imageObj) {
    if (imageObj == null) return null;
    String url = imageObj.toString();
    if (url.isEmpty || url.toLowerCase() == 'null') return null;
    if (url.startsWith('http://') || url.startsWith('https://')) return url;
    if (!url.startsWith('/')) url = '/$url';
    return '${EndPoints.baseUrl}$url';
  }
}
