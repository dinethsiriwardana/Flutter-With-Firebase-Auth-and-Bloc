part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthStatusChangedState extends AuthState {
  final User? user;
  final Map<String, dynamic>? status;
  AuthStatusChangedState({required this.status, this.user});
}

class AuthStatusSuccess extends AuthState {}

class AuthStatusError extends AuthState {
  final String? error;
  AuthStatusError({this.error});
}

class LogOutState extends AuthState {}
