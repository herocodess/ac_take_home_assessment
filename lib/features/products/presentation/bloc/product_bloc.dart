// ignore_for_file: depend_on_referenced_packages

import 'package:acumen_technical_assessment/core/exception/network_exception.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/features/products/data/datasource/products_datasource.dart';
import 'package:acumen_technical_assessment/features/products/data/model/products_model.dart';
import 'package:acumen_technical_assessment/features/products/data/repository/abstract_product_repository.dart';
import 'package:acumen_technical_assessment/features/products/data/repository/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({ProductRepository? productRepository})
      : _productRepository = productRepository ??
            ProductRepositoryImpl(
              productsDatasource: ProductsDatasource(),
            ),
        super(ProductInitial()) {
    on<FetchCategoriesEvent>(
        (FetchCategoriesEvent event, Emitter<ProductState> emit) async {
      try {
        emit(FetchCategoriesLoadingState());
        final response = await _productRepository.fetchAllCategories();
        response.fold(
          (l) => emit(FetchCategoriesFailureState(error: l)),
          (r) {
            final List<String> categories =
                r.data!.map<String>((e) => e.toString()).toList();
            emit(FetchCategoriesSuccessState(categories: categories));
          },
        );
      } on DioError catch (e) {
        final ex = NetworkExceptions.getDioException(e);
        emit(FetchCategoriesFailureState(error: ex));
      }
    });
    on<FetchProductsEvent>(
        (FetchProductsEvent event, Emitter<ProductState> emit) async {
      try {
        emit(FetchProductsLoadingState());
        final response =
            await _productRepository.fetchAllProducts(event.params);
        response.fold(
          (l) => emit(FetchProductsFailureState(error: l)),
          (r) {
            emit(FetchProductsSuccessState(products: r));
          },
        );
      } on DioError catch (e) {
        final ex = NetworkExceptions.getDioException(e);
        emit(FetchProductsFailureState(error: ex));
      }
    });
  }

  final ProductRepository _productRepository;
}
