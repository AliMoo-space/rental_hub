import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/home/data/datasource/product_remote_data_source.dart';
import 'package:rental_hub/feature/home/data/models/product_model.dart';

class ProductRemoteDataSourceImp implements ProductRemoteDataSource {
  final ApiConsumer _api;

  ProductRemoteDataSourceImp(this._api);

  @override
  Future<ProductsModel> getProducts({required int pageNumber}) async {
    final response = await _api.get(
      EndPoints.productsEndpoint,
      queryParameters: {'pageNumber': pageNumber, 'pageSize': 10},
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    return ProductsModel.fromJson(payload);
  }
}
