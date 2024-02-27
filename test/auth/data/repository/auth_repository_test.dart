import 'package:acumen_technical_assessment/core/api/abstract_api_response.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/features/auth/data/datasource/auth_datasource.dart';
import 'package:acumen_technical_assessment/features/auth/data/repository/abstract_auth_repository.dart';
import 'package:acumen_technical_assessment/features/auth/data/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  group('Auth Repo Test - ', () {
    late AuthDataSource authDataSource;
    late AuthRepository authRepository;

    setUp(() {
      authDataSource = MockAuthDataSource();
      authRepository = AuthRepositoryImpl(authDataSource: authDataSource);
    });

    test(
        'test that login function returns success of [Right<AbstractApiResponse>]',
        () async {
      when(() {
        final RequestParams<String> data = {
          "email": "user1@gmail.com",
          "password": "001122",
        };
        return authDataSource.login(data);
      }).thenAnswer((invocation) async {
        return AbstractApiResponse(
          error: false,
          message: 'User signed in successfully',
        );
      });

      final result = await authRepository.login({
        "email": "user1@gmail.com",
        "password": "001122",
      });
      result.fold((l) {}, (r) {
        expect(r.error, false);
      });
      expect(result, isA<Right<String, AbstractApiResponse>>());
    });

    test('test that login function returns error of [Left<String>]', () async {
      when(() {
        final RequestParams<String> data = {
          "email": "user1@gmail.com",
          "password": "001122",
        };
        return authDataSource.login(data);
      }).thenAnswer((invocation) async {
        return AbstractApiResponse(
          error: false,
          message: 'error',
        );
      });

      final result = await authRepository.login({
        "email": "user1@gmail.com",
        "password": "001122",
      });
      result.fold((l) {}, (r) {
        expect(r.message, isNot('User signed in successfully'));
      });

      expect(result, isA<Left<String, AbstractApiResponse>>());
    });
  });
}
