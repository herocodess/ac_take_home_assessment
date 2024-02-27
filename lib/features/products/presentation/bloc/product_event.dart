part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchCategoriesEvent extends ProductEvent {}

class FetchProductsEvent extends ProductEvent {
  FetchProductsEvent({required this.params});
  final RequestParams<String> params;
}
