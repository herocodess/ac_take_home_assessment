import 'package:acumen_technical_assessment/core/api/abstract_api_response.dart';
import 'package:acumen_technical_assessment/core/api/api_client.dart';
import 'package:acumen_technical_assessment/core/api/endpoints.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';

class AuthDataSource {
  AuthDataSource({ApiClient? client}) : _client = client ?? ApiClient();
  final ApiClient _client;

  Future<AbstractApiResponse> login(RequestParams<String> data) async {
    final response = await _client.post(Endpoints.login, data: data);
    return ApiResponseHelper.handleResponse(response);
  }
}
