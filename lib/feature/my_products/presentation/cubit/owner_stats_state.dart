import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/my_products/domain/entities/owner_stats_entity.dart';
import 'package:rental_hub/feature/my_products/domain/entities/product_rental_request_entity.dart';
import 'package:rental_hub/feature/my_products/domain/entities/product_stats_entity.dart';
import 'package:rental_hub/feature/my_products/domain/entities/product_transaction_entity.dart';

class OwnerStatsState extends Equatable {
  final bool isOwnerStatsLoading;
  final bool isProductStatsLoading;
  final bool isTransactionsLoading;
  final bool isRequestsLoading;
  final OwnerStatsEntity? ownerStats;
  final ProductStatsEntity? productStats;
  final List<ProductTransactionEntity> transactions;
  final List<ProductRentalRequestEntity> rentalRequests;
  final String errorMessage;

  const OwnerStatsState({
    this.isOwnerStatsLoading = false,
    this.isProductStatsLoading = false,
    this.isTransactionsLoading = false,
    this.isRequestsLoading = false,
    this.ownerStats,
    this.productStats,
    this.transactions = const [],
    this.rentalRequests = const [],
    this.errorMessage = '',
  });

  OwnerStatsState copyWith({
    bool? isOwnerStatsLoading,
    bool? isProductStatsLoading,
    bool? isTransactionsLoading,
    bool? isRequestsLoading,
    OwnerStatsEntity? ownerStats,
    ProductStatsEntity? productStats,
    List<ProductTransactionEntity>? transactions,
    List<ProductRentalRequestEntity>? rentalRequests,
    String? errorMessage,
  }) {
    return OwnerStatsState(
      isOwnerStatsLoading: isOwnerStatsLoading ?? this.isOwnerStatsLoading,
      isProductStatsLoading:
          isProductStatsLoading ?? this.isProductStatsLoading,
      isTransactionsLoading:
          isTransactionsLoading ?? this.isTransactionsLoading,
      isRequestsLoading: isRequestsLoading ?? this.isRequestsLoading,
      ownerStats: ownerStats ?? this.ownerStats,
      productStats: productStats ?? this.productStats,
      transactions: transactions ?? this.transactions,
      rentalRequests: rentalRequests ?? this.rentalRequests,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isOwnerStatsLoading,
    isProductStatsLoading,
    isTransactionsLoading,
    isRequestsLoading,
    ownerStats,
    productStats,
    transactions,
    rentalRequests,
    errorMessage,
  ];
}
