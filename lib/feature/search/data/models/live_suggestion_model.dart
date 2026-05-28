import 'package:rental_hub/feature/search/domain/entities/live_suggestion_entity.dart';

class LiveSuggestionModel extends LiveSuggestionEntity {
  LiveSuggestionModel({
    required super.id,
    required super.name,
    required super.category,
    super.brand,
    required super.condition,
    required super.pricePerDay,
    required super.location,
    super.rentalGuarantee,
    super.status,
    super.imageUrl,
  });

  factory LiveSuggestionModel.fromJson(Map<String, dynamic> json) {
    return LiveSuggestionModel(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String? ?? '',
      brand: json['brand'] as String?,
      condition: json['condition'] as String? ?? '',
      pricePerDay: (json['price_per_day'] as num?)?.toDouble() ?? 0.0,
      location: json['location'] as String? ?? '',
      rentalGuarantee: json['rental_guarantee'] as bool? ?? false,
      status: json['status'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }
}
