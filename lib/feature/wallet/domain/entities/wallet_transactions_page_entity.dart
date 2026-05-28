import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_transaction_entity.dart';

class WalletTransactionsPageEntity extends Equatable {
  final List<WalletTransactionEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final bool hasPrevious;
  final bool hasNext;

  const WalletTransactionsPageEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.hasPrevious,
    required this.hasNext,
  });

  @override
  List<Object> get props => [
    items,
    totalCount,
    pageNumber,
    pageSize,
    totalPages,
    hasPrevious,
    hasNext,
  ];
}
