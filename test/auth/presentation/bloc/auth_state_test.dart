import 'package:acumen_technical_assessment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('login state test ', () {
    test('AuthInitial', () {
      AuthInitial state = AuthInitial();

      expect(state, const TypeMatcher<AuthInitial>());
    });

    test('LoginLoadingState', () {
      LoginLoadingState state = LoginLoadingState();

      expect(state, const TypeMatcher<LoginLoadingState>());
    });

    test('LoginSuccessState', () {
      LoginSuccessState state = LoginSuccessState();

      expect(state, const TypeMatcher<LoginSuccessState>());
    });

    test('LoginFailureState', () {
      LoginFailureState state = LoginFailureState(error: 'error');

      expect(
        state,
        const TypeMatcher<LoginFailureState>().having(
          (LoginFailureState loginFailureState) => loginFailureState.error,
          'login error',
          isNot('User signed in successfully'),
        ),
      );
    });
  });
}
