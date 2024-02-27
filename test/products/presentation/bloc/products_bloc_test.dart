import 'package:acumen_technical_assessment/core/api/abstract_api_response.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/features/products/data/model/products_model.dart';
import 'package:acumen_technical_assessment/features/products/data/repository/abstract_product_repository.dart';
import 'package:acumen_technical_assessment/features/products/presentation/bloc/product_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsRepository extends Mock implements ProductRepository {}

void main() {
  group('Product Bloc Test', () {
    late ProductRepository productRepository;
    late ProductBloc productBloc;

    setUp(() {
      productRepository = MockProductsRepository();
      productBloc = ProductBloc(productRepository: productRepository);
    });

    test('inital state is ProductInitial', () {
      expect(productBloc.state, const TypeMatcher<ProductInitial>());
    });

    group('categories', () {
      blocTest<ProductBloc, ProductState>(
        'FetchCategoriesEvent - emits FetchCategoriesSuccess',
        setUp: () {
          final response = Right<String, AbstractApiResponse>(
              AbstractApiResponse(data: ['categories1', 'categories2']));
          when(() => productRepository.fetchAllCategories())
              .thenAnswer((_) async => response);
        },
        build: () => productBloc,
        act: (ProductBloc bloc) async {
          bloc.add(FetchCategoriesEvent());
        },
        expect: () {
          return ([
            const TypeMatcher<FetchCategoriesLoadingState>(),
            const TypeMatcher<FetchCategoriesSuccessState>(),
          ]);
        },
      );

      blocTest<ProductBloc, ProductState>(
        'FetchCategoriesEvent - emits FetchCategoriesFailure',
        setUp: () {
          const response =
              Left<String, AbstractApiResponse>('failed to fetch categories');
          when(() => productRepository.fetchAllCategories())
              .thenAnswer((_) async => response);
        },
        build: () => productBloc,
        act: (ProductBloc bloc) async {
          bloc.add(FetchCategoriesEvent());
        },
        expect: () {
          return ([
            const TypeMatcher<FetchCategoriesLoadingState>(),
            const TypeMatcher<FetchCategoriesFailureState>(),
          ]);
        },
      );

      blocTest<ProductBloc, ProductState>(
        'LoginUserEvent - emits FetchCategoriesFailure when DioError is shown',
        setUp: () {
          final dioError = DioError(
            requestOptions: RequestOptions(path: '/categories'),
          );
          when(() => productRepository.fetchAllCategories())
              .thenThrow(dioError);
        },
        build: () => productBloc,
        act: (ProductBloc bloc) async {
          bloc.add(FetchCategoriesEvent());
        },
        expect: () {
          return ([
            const TypeMatcher<FetchCategoriesLoadingState>(),
            const TypeMatcher<FetchCategoriesFailureState>(),
          ]);
        },
      );
    });

    group('products', () {
      blocTest<ProductBloc, ProductState>(
        'FetchProductsEvent - emits FetchProductsLoadingState',
        setUp: () {
          final RequestParams<String> params = {
            'category': 'category',
          };
          final products = <ProductsModel>[
            ProductsModel(
                name: 'prouduct 1',
                image: 'https://image1.com',
                price: 100,
                quantity: 1,
                category: 'hair'),
            ProductsModel(
                name: 'prouduct 1',
                image: 'https://image1.com',
                price: 100,
                quantity: 1,
                category: 'hair')
          ];
          final response = Right<String, List<ProductsModel>>(products);
          when(() => productRepository.fetchAllProducts(params))
              .thenAnswer((_) async => response);
        },
        build: () => productBloc,
        act: (ProductBloc bloc) async {
          final RequestParams<String> params = {
            'category': 'category',
          };
          bloc.add(FetchProductsEvent(params: params));
        },
        expect: () {
          return ([
            const TypeMatcher<FetchProductsLoadingState>(),
            const TypeMatcher<FetchProductsSuccessState>(),
          ]);
        },
      );

      blocTest<ProductBloc, ProductState>(
        'FetchProductsEvent - emits FetchProductsFailureState',
        setUp: () {
          final RequestParams<String> params = {
            'category': 'category',
          };
          const response =
              Left<String, List<ProductsModel>>('failed to fetch products');
          when(() => productRepository.fetchAllProducts(params))
              .thenAnswer((_) async => response);
        },
        build: () => productBloc,
        act: (ProductBloc bloc) async {
          final RequestParams<String> params = {
            'category': 'category',
          };
          bloc.add(FetchProductsEvent(params: params));
        },
        expect: () {
          return ([
            const TypeMatcher<FetchProductsLoadingState>(),
            const TypeMatcher<FetchProductsFailureState>(),
          ]);
        },
      );

      blocTest<ProductBloc, ProductState>(
        'FetchProductsEvent - emits FetchProductsFailureState when DioError is shown',
        setUp: () {
          final dioError = DioError(
            requestOptions: RequestOptions(path: '/products?category=category'),
          );
          final RequestParams<String> params = {
            'category': 'category',
          };
          when(() => productRepository.fetchAllProducts(params))
              .thenThrow(dioError);
        },
        build: () => productBloc,
        act: (ProductBloc bloc) async {
          final RequestParams<String> params = {
            'category': 'category',
          };
          bloc.add(FetchProductsEvent(params: params));
        },
        expect: () {
          return ([
            const TypeMatcher<FetchProductsLoadingState>(),
            const TypeMatcher<FetchProductsFailureState>(),
          ]);
        },
      );
    });
  });
}
