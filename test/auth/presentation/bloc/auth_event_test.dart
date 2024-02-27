import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('login event test', () {
    test('should properly initialize with parameters', () {
      final RequestParams<String> params = {
        "email": "user1@gmail.com",
        "password": "001122",
      };

      LoginUserEvent event = LoginUserEvent(params: params);

      expect(event.params, isNotEmpty);
      expect(event.params, equals(params));
    });
  });
}
