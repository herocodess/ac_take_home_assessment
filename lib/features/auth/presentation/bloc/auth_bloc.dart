// ignore_for_file: depend_on_referenced_packages

import 'package:acumen_technical_assessment/core/exception/network_exception.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/features/auth/data/datasource/auth_datasource.dart';
import 'package:acumen_technical_assessment/features/auth/data/repository/abstract_auth_repository.dart';
import 'package:acumen_technical_assessment/features/auth/data/repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({AuthRepository? authRepository})
      : _authRepository = authRepository ??
            AuthRepositoryImpl(
              authDataSource: AuthDataSource(),
            ),
        super(AuthInitial()) {
    on<LoginUserEvent>((LoginUserEvent event, Emitter<AuthState> emit) async {
      try {
        emit(LoginLoadingState());
        final response = await _authRepository.login(event.params);
        response.fold(
          (l) => emit(LoginFailureState(error: l)),
          (r) {
            emit(LoginSuccessState());
          },
        );
      } on DioError catch (e) {
        final ex = NetworkExceptions.getDioException(e);
        emit(LoginFailureState(error: ex));
      }
    });
  }

  final AuthRepository _authRepository;
}
