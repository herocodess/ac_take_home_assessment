import 'package:acumen_technical_assessment/core/api/abstract_api_response.dart';
import 'package:acumen_technical_assessment/core/api/api_client.dart';
import 'package:acumen_technical_assessment/core/api/endpoints.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/features/auth/data/datasource/auth_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('Test login method', () {
    late ApiClient apiClient;
    late AuthDataSource authDataSource;
    setUp(() {
      apiClient = MockApiClient();
      authDataSource = AuthDataSource(client: apiClient);
    });

    test('login', () async {
      when(() {
        final RequestParams<String> data = {
          "email": "user1@gmail.com",
          "password": "001122",
        };
        return apiClient.post(Endpoints.login, data: data);
      }).thenAnswer((invocation) async {
        return Future<Response>.value(
          Response(
            data: {},
            requestOptions: RequestOptions(path: '/login'),
          ),
        );
      });

      final result = await authDataSource.login({
        "email": "user1@gmail.com",
        "password": "001122",
      });
      expect(result, isA<AbstractApiResponse>());
    });
  });
}
