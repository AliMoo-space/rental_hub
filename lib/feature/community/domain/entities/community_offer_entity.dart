import 'package:equatable/equatable.dart';

class CommunityOfferEntity extends Equatable {
  final int id;
  final int requestId;
  final String? requestTitle;
  final double proposedPrice;
  final String message;
  final String? imageUrl;
  final String governorate;
  final String city;
  final String address;
  final String offererId;
  final String offererName;
  final String? offererImageUrl;
  final String status;
  final DateTime? createdAt;

  const CommunityOfferEntity({
    required this.id,
    required this.requestId,
    this.requestTitle,
    required this.proposedPrice,
    required this.message,
    this.imageUrl,
    required this.governorate,
    required this.city,
    required this.address,
    required this.offererId,
    required this.offererName,
    this.offererImageUrl,
    required this.status,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    requestId,
    requestTitle,
    proposedPrice,
    message,
    imageUrl,
    governorate,
    city,
    address,
    offererId,
    offererName,
    offererImageUrl,
    status,
    createdAt,
  ];
}

class CommunityOffersPageEntity extends Equatable {
  final List<CommunityOfferEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final bool hasPrevious;
  final bool hasNext;

  const CommunityOffersPageEntity({
    required this.items,
    this.totalCount = 0,
    this.pageNumber = 1,
    this.pageSize = 10,
    this.totalPages = 0,
    this.hasPrevious = false,
    this.hasNext = false,
  });

  @override
  List<Object?> get props => [
    items,
    totalCount,
    pageNumber,
    pageSize,
    totalPages,
    hasPrevious,
    hasNext,
  ];
}
