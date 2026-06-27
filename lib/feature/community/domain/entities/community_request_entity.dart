import 'package:equatable/equatable.dart';

class CommunityRequestEntity extends Equatable {
  final int id;
  final int categoryId;
  final String categoryName;
  final int subcategoryId;
  final String subcategoryName;
  final String governorate;
  final String city;
  final String address;
  final String title;
  final double budget;
  final DateTime? startDate;
  final DateTime? endDate;
  final String description;
  final String? imageUrl;
  final String userId;
  final String userFullName;
  final String? userImageUrl;
  final String status;
  final String? rejectionReason;
  final DateTime? createdAt;
  final int offersCount;

  const CommunityRequestEntity({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.subcategoryId,
    required this.subcategoryName,
    required this.governorate,
    required this.city,
    required this.address,
    required this.title,
    required this.budget,
    this.startDate,
    this.endDate,
    required this.description,
    this.imageUrl,
    required this.userId,
    required this.userFullName,
    this.userImageUrl,
    required this.status,
    this.rejectionReason,
    this.createdAt,
    this.offersCount = 0,
  });

  String get locationLabel {
    final parts = [city, governorate].where((part) => part.trim().isNotEmpty);
    return parts.join(', ');
  }

  @override
  List<Object?> get props => [
    id,
    categoryId,
    categoryName,
    subcategoryId,
    subcategoryName,
    governorate,
    city,
    address,
    title,
    budget,
    startDate,
    endDate,
    description,
    imageUrl,
    userId,
    userFullName,
    userImageUrl,
    status,
    rejectionReason,
    createdAt,
    offersCount,
  ];
}

class CommunityRequestsPageEntity extends Equatable {
  final List<CommunityRequestEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final bool hasPrevious;
  final bool hasNext;

  const CommunityRequestsPageEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.hasPrevious,
    required this.hasNext,
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
