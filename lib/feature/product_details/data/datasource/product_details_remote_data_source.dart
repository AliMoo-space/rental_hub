import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/product_details/data/models/product_details_model.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductDetailsModel> getProductDetails(int id);
}

class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  final ApiConsumer apiConsumer;

  ProductDetailsRemoteDataSourceImpl({required this.apiConsumer});
  @override
  Future<ProductDetailsModel> getProductDetails(int id) async {
    final response = await apiConsumer.get(
      '${EndPoints.productsEndpoint}/admin/$id/details',
    );
    final payLoad = ResponseParser.extractDataPayload(response.data);
    return ProductDetailsModel.fromJson(payLoad);
  }
}
