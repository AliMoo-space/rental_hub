class RentalOrderEntity {
  final int id;
  final int productId;
  final String productName;
  final String productImage;
  final String renterId;
  final String renterName;
  final String ownerId;
  final String ownerName;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String deliveryMethod;
  final String street;
  final String city;
  final String governorate;
  final double rentalPrice;
  final double insurancePrice;
  final double serviceFee;
  final double totalPrice;

  const RentalOrderEntity({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.renterId,
    required this.renterName,
    required this.ownerId,
    required this.ownerName,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.deliveryMethod,
    required this.street,
    required this.city,
    required this.governorate,
    required this.rentalPrice,
    required this.insurancePrice,
    required this.serviceFee,
    required this.totalPrice,
  });

  factory RentalOrderEntity.empty() => RentalOrderEntity(
        id: 0,
        productId: 0,
        productName: '',
        productImage: '',
        renterId: '',
        renterName: '',
        ownerId: '',
        ownerName: '',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: '',
        deliveryMethod: '',
        street: '',
        city: '',
        governorate: '',
        rentalPrice: 0,
        insurancePrice: 0,
        serviceFee: 0,
        totalPrice: 0,
      );
}
