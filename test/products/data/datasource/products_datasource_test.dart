import 'package:acumen_technical_assessment/core/api/abstract_api_response.dart';
import 'package:acumen_technical_assessment/core/api/api_client.dart';
import 'package:acumen_technical_assessment/core/api/endpoints.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/features/products/data/datasource/products_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('Products Datasource Test - ', () {
    late ApiClient apiClient;
    late ProductsDatasource productsDatasource;

    setUp(() {
      apiClient = MockApiClient();
      productsDatasource = ProductsDatasource(client: apiClient);
    });

    test('fetch all categories test - ', () async {
      when(() {
        return apiClient.get(Endpoints.categories);
      }).thenAnswer((invocation) async {
        return Future<Response>.value(
          Response(
            data: {},
            requestOptions: RequestOptions(path: '/categories'),
          ),
        );
      });

      final result = await productsDatasource.fetchAllCategories();

      expect(result, isA<AbstractApiResponse>());
    });

    test('fetch all products with categories test - ', () async {
      when(() {
        final RequestParams<String> params = {
          "category": "category",
        };
        return apiClient.get(
          Endpoints.getProducts(
            category: params['category'],
          ),
        );
      }).thenAnswer((invocation) async {
        return Future<Response>.value(
          Response(
            data: {},
            requestOptions:
                RequestOptions(path: '/products?category="category'),
          ),
        );
      });

      final result = await productsDatasource.fetchAllProducts({
        "category": "category",
      });

      expect(result, isA<AbstractApiResponse>());
    });
  });
}
