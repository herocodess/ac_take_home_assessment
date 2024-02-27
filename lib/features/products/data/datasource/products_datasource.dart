import 'package:acumen_technical_assessment/core/api/abstract_api_response.dart';
import 'package:acumen_technical_assessment/core/api/api_client.dart';
import 'package:acumen_technical_assessment/core/api/endpoints.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';

class ProductsDatasource {
  ProductsDatasource({ApiClient? client}) : _client = client ?? ApiClient();
  final ApiClient _client;

  Future<AbstractApiResponse> fetchAllCategories() async {
    final response = await _client.get(Endpoints.categories);
    return ApiResponseHelper.handleResponse(response);
  }

  Future<AbstractApiResponse> fetchAllProducts(
      RequestParams<String> data) async {
    final response = await _client.get(
      Endpoints.getProducts(category: data['category']),
    );
    return ApiResponseHelper.handleResponse(response);
  }
}
