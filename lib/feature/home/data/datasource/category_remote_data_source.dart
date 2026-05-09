import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/home/data/models/category_model.dart';

class CategoryRemoteDataSource {
  final ApiConsumer _api;

  CategoryRemoteDataSource(this._api);

  Future<CategoryModel> getCategories() async {
    try {
      print(' Fetching categories from API...');
      final response = await _api.get(EndPoints.categoriesEndpoint);
      print(' API Raw Response: $response');

      final payload = ResponseParser.extractDataPayload(response.data);
      print('Extracted Payload: $payload');
      print('Payload keys: ${payload.keys.toList()}');

      // الـ API ترجع الـ payload مباشرة أو مع wrapper
      final categoryJson = payload.isEmpty ? response.data : payload;
      print('Using JSON: $categoryJson');

      return CategoryModel.fromJson(categoryJson);
    } catch (e) {
      print('Error in getCategories: $e');
      print('Stack: ${StackTrace.current}');
      rethrow;
    }
  }
}
