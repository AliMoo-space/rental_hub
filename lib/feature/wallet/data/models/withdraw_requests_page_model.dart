import 'package:rental_hub/core/models/paginated_response_model.dart';
import 'package:rental_hub/feature/wallet/data/models/withdraw_request_model.dart';
import 'package:rental_hub/feature/wallet/domain/entities/withdraw_request_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/withdraw_requests_page_entity.dart';

class WithdrawRequestsPageModel extends WithdrawRequestsPageEntity {
  const WithdrawRequestsPageModel({
    required super.items,
    required super.totalCount,
    required super.pageNumber,
    required super.pageSize,
    required super.totalPages,
    required super.hasPrevious,
    required super.hasNext,
  });

  factory WithdrawRequestsPageModel.fromJson(Map<String, dynamic> json) {
    final page = PaginatedResponseModel<WithdrawRequestEntity>.fromJson(
      json,
      WithdrawRequestModel.fromJson,
    );

    return WithdrawRequestsPageModel(
      items: page.items,
      totalCount: page.totalCount,
      pageNumber: page.pageNumber,
      pageSize: page.pageSize,
      totalPages: page.totalPages,
      hasPrevious: page.hasPrevious,
      hasNext: page.hasNext,
    );
  }
}
