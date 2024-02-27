part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class FetchCategoriesLoadingState extends ProductState {}

class FetchCategoriesSuccessState extends ProductState {
  FetchCategoriesSuccessState({required this.categories});
  final List<String> categories;
}

class FetchCategoriesFailureState extends ProductState {
  FetchCategoriesFailureState({required this.error});
  final String error;
}

class FetchProductsLoadingState extends ProductState {}

class FetchProductsSuccessState extends ProductState {
  FetchProductsSuccessState({required this.products});
  final List<ProductsModel> products;
}

class FetchProductsFailureState extends ProductState {
  FetchProductsFailureState({required this.error});
  final String error;
}
