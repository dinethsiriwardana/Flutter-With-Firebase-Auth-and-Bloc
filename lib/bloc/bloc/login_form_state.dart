part of 'login_form_bloc.dart';

@immutable
sealed class LoginFormState {}

final class LoginFormInitial extends LoginFormState {}

class FormChangedState extends LoginFormState {
  final bool isLogin;
  FormChangedState({required this.isLogin});
}
