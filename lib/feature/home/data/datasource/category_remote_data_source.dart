import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/home/data/models/category_model.dart';

class CategoryRemoteDataSource {
  final ApiConsumer _api;

  CategoryRemoteDataSource(this._api);

  Future<CategoryModel> getCategories() async {
    final response = await _api.get(
      EndPoints.categoriesEndpoint,
      queryParameters: const {'PageNumber': 1, 'PageSize': 100},
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    final categoryJson = payload.isEmpty ? response.data : payload;

    return CategoryModel.fromJson(categoryJson);
  }

  Future<List<SubCategoryModel>> getSubcategories(int categoryId) async {
    final response = await _api.get(
      '${EndPoints.categoriesEndpoint}/$categoryId/subcategories',
      queryParameters: const {'PageNumber': 1, 'PageSize': 100},
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    final items = _extractItems(payload.isEmpty ? response.data : payload);

    return items
        .whereType<Map<String, dynamic>>()
        .map(SubCategoryModel.fromJson)
        .toList();
  }

  List<dynamic> _extractItems(dynamic payload) {
    if (payload is Map<String, dynamic>) {
      final items = payload['items'];
      if (items is List) {
        return items;
      }
    }

    if (payload is List) {
      return payload;
    }

    return const [];
  }
}
