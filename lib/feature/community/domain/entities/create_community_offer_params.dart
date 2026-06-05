import 'package:equatable/equatable.dart';

class CreateCommunityOfferParams extends Equatable {
  final int requestId;
  final double proposedPrice;
  final String message;
  final String governorate;
  final String city;
  final String address;

  const CreateCommunityOfferParams({
    required this.requestId,
    required this.proposedPrice,
    required this.message,
    required this.governorate,
    required this.city,
    required this.address,
  });

  @override
  List<Object?> get props => [
    requestId,
    proposedPrice,
    message,
    governorate,
    city,
    address,
  ];
}
