import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/error_model.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/add_listing/data/models/create_product_request.dart';
import 'package:rental_hub/feature/add_listing/data/models/update_product_request.dart';

abstract class AddListingRemoteDataSource {
  Future<String> createProduct(CreateProductRequest request);
  Future<String> updateProduct(int id, UpdateProductRequest request);
}

class AddListingRemoteDataSourceImpl implements AddListingRemoteDataSource {
  final ApiConsumer apiConsumer;

  AddListingRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<String> createProduct(CreateProductRequest request) async {
    final response = await apiConsumer.post(
      EndPoints.productsEndpoint,
      data: await request.toFormData(),
      isFormData: true,
    );

    final payload = ResponseParser.extractMessagePayload(
      response.data,
      defaultMessage: 'تمت إضافة المنتج بنجاح',
    );

    final message = payload['message']?.toString().trim() ?? '';
    if (message.isEmpty) {
      throw ServerException(
        ErrorModel(
          statusCode: response.statusCode ?? 500,
          message: 'Invalid create product response format',
          errors: {},
        ),
      );
    }

    return message;
  }

  @override
  Future<String> updateProduct(int id, UpdateProductRequest request) async {
    final response = await apiConsumer.put(
      '${EndPoints.productsEndpoint}/$id',
      data: await request.toFormData(),
    );

    final payload = ResponseParser.extractMessagePayload(
      response.data,
      defaultMessage: 'تم تعديل المنتج بنجاح',
    );

    final message = payload['message']?.toString().trim() ?? '';
    if (message.isEmpty) {
      throw ServerException(
        ErrorModel(
          statusCode: response.statusCode ?? 500,
          message: 'Invalid update product response format',
          errors: {},
        ),
      );
    }

    return message;
  }
}
