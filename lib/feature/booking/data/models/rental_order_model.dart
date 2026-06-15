import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';

class RentalOrderModel extends RentalOrderEntity {
  const RentalOrderModel({
    required super.id,
    required super.productId,
    required super.productName,
    required super.productImage,
    required super.renterId,
    required super.renterName,
    required super.ownerId,
    required super.ownerName,
    required super.startDate,
    required super.endDate,
    required super.status,
    required super.deliveryMethod,
    required super.street,
    required super.city,
    required super.governorate,
    required super.rentalPrice,
    required super.insurancePrice,
    required super.serviceFee,
    required super.totalPrice,
  });

  factory RentalOrderModel.fromJson(Map<String, dynamic> json) {
    return RentalOrderModel(
      id: json['id'] ?? 0,
      productId: json['productId'] ?? 0,
      productName: json['productName'] ?? '',
      productImage: json['productImage'] ?? '',
      renterId: json['renterId'] ?? '',
      renterName: json['renterName'] ?? '',
      ownerId: json['ownerId'] ?? '',
      ownerName: json['ownerName'] ?? '',
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'])
          : DateTime.now(),
      status: json['status'] ?? '',
      deliveryMethod: json['deliveryMethod'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      governorate: json['governorate'] ?? '',
      rentalPrice: (json['rentalPrice'] ?? 0).toDouble(),
      insurancePrice: (json['insurancePrice'] ?? 0).toDouble(),
      serviceFee: (json['serviceFee'] ?? 0).toDouble(),
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
    );
  }
}
