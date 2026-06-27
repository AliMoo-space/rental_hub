import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/home/data/datasource/product_remote_data_source.dart';
import 'package:rental_hub/feature/home/data/models/product_model.dart';
import 'dart:developer' as developer;

class ProductRemoteDataSourceImp implements ProductRemoteDataSource {
  final ApiConsumer _api;

  ProductRemoteDataSourceImp(this._api);

  @override
  Future<ProductsModel> getProducts({required int pageNumber}) async {
    developer.log(
      'API count start: getProducts page $pageNumber',
      name: 'Instrumentation',
    );
    final response = await _api.get(
      EndPoints.productsEndpoint,
      queryParameters: {'pageNumber': pageNumber, 'pageSize': 10},
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    developer.log(
      'Parsed count pre-model payload items: ${(payload['items'] as List?)?.length}',
      name: 'Instrumentation',
    );
    final model = ProductsModel.fromJson(payload);
    developer.log(
      'Parsed count post-model: ${model.items.length}',
      name: 'Instrumentation',
    );
    return model;
  }
}
