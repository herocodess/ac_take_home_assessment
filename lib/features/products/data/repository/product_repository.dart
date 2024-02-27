import 'package:acumen_technical_assessment/core/api/abstract_api_response.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/features/products/data/datasource/products_datasource.dart';
import 'package:acumen_technical_assessment/features/products/data/model/products_model.dart';
import 'package:acumen_technical_assessment/features/products/data/repository/abstract_product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductsDatasource productsDatasource;

  ProductRepositoryImpl({
    required this.productsDatasource,
  });

  @override
  ResponseFormat<AbstractApiResponse> fetchAllCategories() async {
    final response = await productsDatasource.fetchAllCategories();

    if (response.data != [] || response.data != null) {
      return Right(response);
    } else {
      return Left(response.message ?? 'Failed to fetch categories');
    }
  }

  @override
  ResponseFormat<List<ProductsModel>> fetchAllProducts(
      RequestParams<String> params) async {
    final response = await productsDatasource.fetchAllProducts(params);
    if (response.data != [] || response.data != null) {
      final data = response.data!
          .map<ProductsModel>((e) => ProductsModel.fromJson(e))
          .toList(growable: false);
      return Right(data);
    } else {
      return Left(response.message ?? 'Failed to fetch products list');
    }
  }
}
