import 'package:acumen_technical_assessment/core/api/abstract_api_response.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';

abstract class AuthRepository {
  ResponseFormat<AbstractApiResponse> login(RequestParams<String> params);
}
