import 'package:equatable/equatable.dart';

class CommunityRequestsQuery extends Equatable {
  final int? categoryId;
  final int? subcategoryId;
  final String? governorate;
  final String? city;
  final String? search;
  final int pageNumber;
  final int pageSize;

  const CommunityRequestsQuery({
    this.categoryId,
    this.subcategoryId,
    this.governorate,
    this.city,
    this.search,
    this.pageNumber = 1,
    this.pageSize = 10,
  });

  @override
  List<Object?> get props => [
    categoryId,
    subcategoryId,
    governorate,
    city,
    search,
    pageNumber,
    pageSize,
  ];
}

class MyCommunityRequestsQuery extends Equatable {
  final String? status;
  final int pageNumber;
  final int pageSize;

  const MyCommunityRequestsQuery({
    this.status,
    this.pageNumber = 1,
    this.pageSize = 10,
  });

  @override
  List<Object?> get props => [status, pageNumber, pageSize];
}
