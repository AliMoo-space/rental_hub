class CreateRentalOrderDto {
  final int productId;
  final DateTime startDate;
  final DateTime endDate;
  final String deliveryMethod;
  final String street;
  final String city;
  final String governorate;
  final bool termsAgreed;

  const CreateRentalOrderDto({
    required this.productId,
    required this.startDate,
    required this.endDate,
    required this.deliveryMethod,
    required this.street,
    required this.city,
    required this.governorate,
    required this.termsAgreed,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate.toUtc().toIso8601String(),
      'deliveryMethod': deliveryMethod,
      'street': street,
      'city': city,
      'governorate': governorate,
      'termsAgreed': termsAgreed,
    };
  }
}
