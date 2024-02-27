import 'package:acumen_technical_assessment/core/api/abstract_api_response.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/features/auth/data/datasource/auth_datasource.dart';
import 'package:acumen_technical_assessment/features/auth/data/repository/abstract_auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({
    required this.authDataSource,
  });
  @override
  ResponseFormat<AbstractApiResponse> login(
      RequestParams<String> params) async {
    final response = await authDataSource.login(params);
    if (response.error == false &&
        response.message == 'User signed in successfully') {
      return Right(response);
    } else {
      return Left(response.message ?? '');
    }
  }
}
