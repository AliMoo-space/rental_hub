class LiveSuggestionEntity {
  final int id;
  final String name;
  final String category;
  final String? brand;
  final String condition;
  final double pricePerDay;
  final String location;
  final bool? rentalGuarantee;
  final String? status;
  final String? imageUrl;

  LiveSuggestionEntity({
    required this.id,
    required this.name,
    required this.category,
    this.brand,
    required this.condition,
    required this.pricePerDay,
    required this.location,
    this.rentalGuarantee,
    this.status,
    this.imageUrl,
  });
}
