import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/home/data/models/category_model.dart';

class CategoryRemoteDataSource {
  final ApiConsumer _api;

  CategoryRemoteDataSource(this._api);

  Future<CategoryModel> getCategories() async {
    final response = await _api.get(EndPoints.categoriesEndpoint);
    final payload = ResponseParser.extractDataPayload(response.data);
    final categoryJson = payload.isEmpty ? response.data : payload;

    return CategoryModel.fromJson(categoryJson);
  }
}
