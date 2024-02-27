part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginUserEvent extends AuthEvent {
  LoginUserEvent({required this.params});
  final RequestParams<String> params;
}
