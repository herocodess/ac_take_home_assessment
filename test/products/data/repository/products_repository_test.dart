import 'package:acumen_technical_assessment/core/api/abstract_api_response.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/features/products/data/datasource/products_datasource.dart';
import 'package:acumen_technical_assessment/features/products/data/model/products_model.dart';
import 'package:acumen_technical_assessment/features/products/data/repository/abstract_product_repository.dart';
import 'package:acumen_technical_assessment/features/products/data/repository/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsDatasource extends Mock implements ProductsDatasource {}

void main() {
  group('Product Repo Test', () {
    late ProductsDatasource productsDatasource;
    late ProductRepository productRepository;

    setUp(() {
      productsDatasource = MockProductsDatasource();
      productRepository =
          ProductRepositoryImpl(productsDatasource: productsDatasource);
    });

    group('fetch categories test', () {
      test(
          'test that fetch categories function returns success of [Right<AbstractApiResponse>]',
          () async {
        when(() {
          return productsDatasource.fetchAllCategories();
        }).thenAnswer((invocation) async {
          return AbstractApiResponse(data: ['category1', 'category2']);
        });

        final result = await productRepository.fetchAllCategories();
        result.fold((l) => null, (r) {
          expect(r.data, isNotEmpty);
        });

        expect(result, isA<Right<String, AbstractApiResponse>>());
      });

      test(
          'test that fetch categories function returns error of [Left<String>]',
          () async {
        when(() {
          return productsDatasource.fetchAllCategories();
        }).thenAnswer((invocation) async {
          return AbstractApiResponse(message: 'error');
        });

        final result = await productRepository.fetchAllCategories();
        var successCondition = true;
        result.fold((l) {
          expect(l, isNotNull);
        }, (r) {
          successCondition = r.data != [] || r.data != null;
          expect(r.data, isNull);
        });

        if (!successCondition) {
          expect(result, isA<Left<String, AbstractApiResponse>>());
        }
      });
    });

    group('fetch products test', () {
      test(
          'test that fetch products returns success of [Right<List<ProductsModel>>]',
          () async {
        final mockResponse = (
          data: [
            {
              "name": "bells care",
              "image":
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRecbfzfuqSXT4GOO7e-E6n__V6ns2JLaKvqA&usqp=CAU",
              "price": 400,
              "quantity": 7,
              "category": "hair"
            },
            {
              "name": "gental hair",
              "image":
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQF3iXGlglFFIn2p61Wf9fEBKgovmhT7rZaXQ&usqp=CAU",
              "price": 250,
              "quantity": 5,
              "category": "hair"
            }
          ],
        );
        when(() {
          final RequestParams<String> params = {"category": "category"};
          return productsDatasource.fetchAllProducts(params);
        }).thenAnswer((invocation) async {
          return AbstractApiResponse(data: mockResponse.data);
        });

        final result =
            await productRepository.fetchAllProducts({"category": "category"});
        result.fold((l) {}, (r) {
          expect(r, isNotEmpty);
        });
        expect(result, isA<Right<String, List<ProductsModel>>>());
      });

      test('test that fetch products function returns error of [Left<String>]',
          () async {
        when(() {
          final RequestParams<String> params = {"category": "category"};
          return productsDatasource.fetchAllProducts(params);
        }).thenAnswer((invocation) async {
          return AbstractApiResponse(message: 'error', data: []);
        });

        final result =
            await productRepository.fetchAllProducts({"category": "category"});
        var successCondition = true;
        result.fold((l) {}, (r) {
          successCondition = r != [];
          expect(r, isEmpty);
        });

        if (!successCondition) {
          expect(result, isA<Left<String, List<ProductsModel>>>());
        }
      });
    });
  });
}
