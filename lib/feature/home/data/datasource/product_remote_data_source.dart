import 'package:rental_hub/feature/home/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductsModel> getProducts({required int pageNumber});
}
