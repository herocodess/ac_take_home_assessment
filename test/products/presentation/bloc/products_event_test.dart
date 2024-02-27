import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('product event test', () {
    test('instance should be created successfully', () {
      final event = FetchCategoriesEvent();

      expect(event, isNotNull);
    });

    test('should properly initialize with parameters', () {
      final RequestParams<String> params = {
        "category": "category",
      };

      FetchProductsEvent event = FetchProductsEvent(params: params);

      expect(event.params, isNotEmpty);
      expect(event.params, equals(params));
    });
  });
}
