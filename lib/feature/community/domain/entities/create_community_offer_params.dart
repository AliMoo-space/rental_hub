import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class CreateCommunityOfferParams extends Equatable {
  final int requestId;
  final double proposedPrice;
  final String message;
  final String governorate;
  final String city;
  final String address;
  final double? insuranceAmount;
  final XFile? image;

  const CreateCommunityOfferParams({
    required this.requestId,
    required this.proposedPrice,
    required this.message,
    required this.governorate,
    required this.city,
    required this.address,
    this.insuranceAmount,
    this.image,
  });

  @override
  List<Object?> get props => [
    requestId,
    proposedPrice,
    message,
    governorate,
    city,
    address,
    insuranceAmount,
    image,
  ];
}
