import 'package:rental_hub/core/models/paginated_response_model.dart';
import 'package:rental_hub/feature/wallet/data/models/wallet_transaction_model.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_transaction_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_transactions_page_entity.dart';

class WalletTransactionsPageModel extends WalletTransactionsPageEntity {
  const WalletTransactionsPageModel({
    required super.items,
    required super.totalCount,
    required super.pageNumber,
    required super.pageSize,
    required super.totalPages,
    required super.hasPrevious,
    required super.hasNext,
  });

  factory WalletTransactionsPageModel.fromJson(Map<String, dynamic> json) {
    final page = PaginatedResponseModel<WalletTransactionEntity>.fromJson(
      json,
      WalletTransactionModel.fromJson,
    );

    return WalletTransactionsPageModel(
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
