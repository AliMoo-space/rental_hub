import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/home/data/models/product_model.dart';

class ProductRemoteDataSource {
  final ApiConsumer _api;

  ProductRemoteDataSource(this._api);

  Future<ProductsModel> getProducts() async {
    final response = await _api.get(EndPoints.productsEndpoint);
    final payload = ResponseParser.extractDataPayload(response.data);
    return ProductsModel.fromJson(payload);
  }
}
