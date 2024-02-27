import 'package:acumen_technical_assessment/core/api/abstract_api_response.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/features/products/data/model/products_model.dart';

abstract class ProductRepository {
  ResponseFormat<AbstractApiResponse> fetchAllCategories();

  ResponseFormat<List<ProductsModel>> fetchAllProducts(
      RequestParams<String> params);
}
