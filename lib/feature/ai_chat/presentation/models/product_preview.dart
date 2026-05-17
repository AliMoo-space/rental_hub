class ProductPreview {
  final int id;
  final String name;
  final double pricePerDay;
  final String? imageUrl;
  final String location;
  final bool rentalGuarantee;
  final String condition;

  const ProductPreview({
    required this.id,
    required this.name,
    required this.pricePerDay,
    this.imageUrl,
    required this.location,
    required this.rentalGuarantee,
    required this.condition,
  });
}
