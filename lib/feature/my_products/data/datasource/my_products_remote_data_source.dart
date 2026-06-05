import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/home/data/models/product_model.dart';
import 'package:rental_hub/feature/my_products/data/models/owner_stats_model.dart';
import 'package:rental_hub/feature/my_products/data/models/product_rental_request_model.dart';
import 'package:rental_hub/feature/my_products/data/models/product_stats_model.dart';
import 'package:rental_hub/feature/my_products/data/models/product_transaction_model.dart';

abstract class MyProductsRemoteDataSource {
  Future<ProductsModel> getMyProducts({required int pageNumber});
  Future<String> deleteProduct({required int id});
  Future<String> suspendProduct({required int id});
  Future<String> activateProduct({required int id});
  Future<OwnerStatsModel> getOwnerStats();
  Future<ProductStatsModel> getProductStats({required int id});
  Future<List<ProductTransactionModel>> getProductTransactions({required int id});
  Future<List<ProductRentalRequestModel>> getProductRentalRequests({required int id});
  Future<double> getCommissionSetting();
}

class MyProductsRemoteDataSourceImpl implements MyProductsRemoteDataSource {
  final ApiConsumer apiConsumer;

  MyProductsRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<ProductsModel> getMyProducts({required int pageNumber}) async {
    final response = await apiConsumer.get(
      EndPoints.myProducts,
      queryParameters: {'PageNumber': pageNumber, 'PageSize': 10},
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    return ProductsModel.fromJson(payload);
  }

  @override
  Future<String> deleteProduct({required int id}) async {
    final response = await apiConsumer.delete(EndPoints.deleteProduct(id));
    final payload = ResponseParser.extractMessagePayload(
      response.data,
      defaultMessage: 'تم حذف المنتج بنجاح',
    );
    return payload['message']?.toString() ?? 'تم حذف المنتج بنجاح';
  }

  @override
  Future<String> suspendProduct({required int id}) async {
    final response = await apiConsumer.put(EndPoints.suspendProduct(id));
    final payload = ResponseParser.extractMessagePayload(
      response.data,
      defaultMessage: 'تم إيقاف المنتج مؤقتاً',
    );
    return payload['message']?.toString() ?? 'تم إيقاف المنتج مؤقتاً';
  }

  @override
  Future<String> activateProduct({required int id}) async {
    final response = await apiConsumer.put(EndPoints.activateProduct(id));
    final payload = ResponseParser.extractMessagePayload(
      response.data,
      defaultMessage: 'تم تفعيل المنتج بنجاح',
    );
    return payload['message']?.toString() ?? 'تم تفعيل المنتج بنجاح';
  }

  @override
  Future<OwnerStatsModel> getOwnerStats() async {
    final response = await apiConsumer.get(EndPoints.ownerStats);
    final payload = ResponseParser.extractDataPayload(response.data);
    return OwnerStatsModel.fromJson(payload);
  }

  @override
  Future<ProductStatsModel> getProductStats({required int id}) async {
    final response = await apiConsumer.get(EndPoints.productStats(id));
    final payload = ResponseParser.extractDataPayload(response.data);
    return ProductStatsModel.fromJson(payload);
  }

  @override
  Future<List<ProductTransactionModel>> getProductTransactions({required int id}) async {
    final response = await apiConsumer.get(EndPoints.productTransactions(id));
    final payload = ResponseParser.extractDataPayload(response.data);
    if (payload is List) {
      return payload.map((e) => ProductTransactionModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    // Fallback if data wraps in a list field
    if (payload is Map && payload['items'] is List) {
      return (payload['items'] as List).map((e) => ProductTransactionModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return [];
  }

  @override
  Future<List<ProductRentalRequestModel>> getProductRentalRequests({required int id}) async {
    final response = await apiConsumer.get(EndPoints.productRentalRequests(id));
    final payload = ResponseParser.extractDataPayload(response.data);
    if (payload is List) {
      return payload.map((e) => ProductRentalRequestModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (payload is Map && payload['items'] is List) {
      return (payload['items'] as List).map((e) => ProductRentalRequestModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return [];
  }

  @override
  Future<double> getCommissionSetting() async {
    final response = await apiConsumer.get(EndPoints.productCommission);
    final payload = ResponseParser.extractDataPayload(response.data);
    if (payload is num) return payload.toDouble();
    if (payload is Map && payload['commission'] is num) {
      return (payload['commission'] as num).toDouble();
    }
    return double.tryParse(payload?.toString() ?? '') ?? 0.0;
  }
}
