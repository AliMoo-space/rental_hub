class AiChatEntity {
  final String answer;
  final String intent;
  final List<ProductChatEntity> products;
  final int totalFound;
  final int latencyMs;
  final bool cached;
  final String? bookingAction;

  AiChatEntity({
    required this.answer,
    required this.intent,
    required this.products,
    required this.totalFound,
    required this.latencyMs,
    required this.cached,
    this.bookingAction,
  });
}

class ProductChatEntity {
  final int id;
  final String name;
  final String category;
  final String brand;
  final String condition;
  final double pricePerDay;
  final String location;
  final bool rentalGuarantee;
  final String status;
  final String? imageUrl;

  ProductChatEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.condition,
    required this.pricePerDay,
    required this.location,
    required this.rentalGuarantee,
    required this.status,
    this.imageUrl,
  });
}
