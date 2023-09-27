part of 'login_form_bloc.dart';

@immutable
sealed class LoginFormEvent {}

class FormChangedEvent extends LoginFormEvent {
  final bool isLogin;
  FormChangedEvent({required this.isLogin});
}
