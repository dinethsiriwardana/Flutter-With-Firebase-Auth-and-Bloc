part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthStatusChangedEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEvent({required this.email, required this.password});
}

class LoginInEvent extends AuthEvent {
  final String email;
  final String password;
  LoginInEvent({required this.email, required this.password});
}

class SignOutEvent extends AuthEvent {}
