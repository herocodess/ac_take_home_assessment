import 'package:acumen_technical_assessment/features/products/data/model/products_model.dart';
import 'package:acumen_technical_assessment/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('product state test', () {
    test('ProductsInitial', () {
      ProductInitial state = ProductInitial();

      expect(state, const TypeMatcher<ProductInitial>());
    });

    group('categories ', () {
      test('FetchCategoriesLoadingState', () {
        FetchCategoriesLoadingState state = FetchCategoriesLoadingState();

        expect(state, const TypeMatcher<FetchCategoriesLoadingState>());
      });

      test('FetchCategoriesSuccessState', () {
        final categories = <String>['categories1', 'categories2'];
        FetchCategoriesSuccessState state =
            FetchCategoriesSuccessState(categories: categories);

        expect(
          state,
          const TypeMatcher<FetchCategoriesSuccessState>().having(
            (FetchCategoriesSuccessState fetchCategoriesSuccessState) =>
                fetchCategoriesSuccessState.categories,
            'categories list',
            categories,
          ),
        );
      });

      test('FetchCategoriesFailureState', () {
        const error = 'Failed to fetch categories';

        FetchCategoriesFailureState state =
            FetchCategoriesFailureState(error: error);

        expect(
          state,
          const TypeMatcher<FetchCategoriesFailureState>().having(
            (FetchCategoriesFailureState fetchCategoriesFailureState) =>
                fetchCategoriesFailureState.error,
            'categories error',
            error,
          ),
        );
      });
    });

    group('products ', () {
      test('FetchProductsLoadingState', () {
        FetchProductsLoadingState state = FetchProductsLoadingState();

        expect(state, const TypeMatcher<FetchProductsLoadingState>());
      });

      test('FetchProductsSuccessState', () {
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
        FetchProductsSuccessState state =
            FetchProductsSuccessState(products: products);

        expect(
          state,
          const TypeMatcher<FetchProductsSuccessState>().having(
            (FetchProductsSuccessState fetchProductsSuccessState) =>
                fetchProductsSuccessState.products,
            'products list',
            products,
          ),
        );
      });

      test('FetchProductsFailureState', () {
        const error = 'Failed to fetch products';

        FetchProductsFailureState state =
            FetchProductsFailureState(error: error);

        expect(
          state,
          const TypeMatcher<FetchProductsFailureState>().having(
            (FetchProductsFailureState fetchProductsFailureState) =>
                fetchProductsFailureState.error,
            'products error',
            error,
          ),
        );
      });
    });
  });
}
