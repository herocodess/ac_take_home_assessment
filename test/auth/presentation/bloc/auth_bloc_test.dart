import 'package:acumen_technical_assessment/core/api/abstract_api_response.dart';
import 'package:acumen_technical_assessment/core/utils/typedefs.dart';
import 'package:acumen_technical_assessment/features/auth/data/repository/abstract_auth_repository.dart';
import 'package:acumen_technical_assessment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('Auth Bloc Test', () {
    late AuthRepository authRepository;
    late AuthBloc authBloc;

    setUp(() {
      authRepository = MockAuthRepository();
      authBloc = AuthBloc(authRepository: authRepository);
    });

    test('initial state is AuthInitial', () {
      expect(authBloc.state, const TypeMatcher<AuthInitial>());
    });

    blocTest<AuthBloc, AuthState>(
      'LoginUserEvent - emits LoginSuccessState when login is successful',
      setUp: () {
        final RequestParams<String> data = {
          "email": "user1@gmail.com",
          "password": "001122",
        };
        final response = Right<String, AbstractApiResponse>(AbstractApiResponse(
          error: false,
          message: 'User signed in successfully',
        ));
        when(() => authRepository.login(data))
            .thenAnswer((_) async => response);
      },
      build: () => authBloc,
      act: (AuthBloc bloc) async {
        final RequestParams<String> data = {
          "email": "user1@gmail.com",
          "password": "001122",
        };
        bloc.add(LoginUserEvent(params: data));
      },
      expect: () {
        return ([
          const TypeMatcher<LoginLoadingState>(),
          const TypeMatcher<LoginSuccessState>(),
        ]);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'LoginUserEvent - emits LoginFailureState when login has an error',
      setUp: () {
        final RequestParams<String> data = {
          "email": "user1@gmail.com",
          "password": "001122",
        };
        const response = Left<String, AbstractApiResponse>('some error');
        when(() => authRepository.login(data))
            .thenAnswer((_) async => response);
      },
      build: () => authBloc,
      act: (AuthBloc bloc) async {
        final RequestParams<String> data = {
          "email": "user1@gmail.com",
          "password": "001122",
        };
        bloc.add(LoginUserEvent(params: data));
      },
      expect: () {
        return ([
          const TypeMatcher<LoginLoadingState>(),
          const TypeMatcher<LoginFailureState>(),
        ]);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'LoginUserEvent - emits LoginFailureState when DioError is shown',
      setUp: () {
        final RequestParams<String> data = {
          "email": "user1@gmail.com",
          "password": "001122",
        };
        final dioError = DioError(
          requestOptions: RequestOptions(path: '/login'),
        );
        when(() => authRepository.login(data)).thenThrow(dioError);
      },
      build: () => authBloc,
      act: (AuthBloc bloc) async {
        final RequestParams<String> data = {
          "email": "user1@gmail.com",
          "password": "001122",
        };
        bloc.add(LoginUserEvent(params: data));
      },
      expect: () {
        return ([
          const TypeMatcher<LoginLoadingState>(),
          const TypeMatcher<LoginFailureState>()
        ]);
      },
    );

    tearDown(() => authBloc.close());
  });
}
