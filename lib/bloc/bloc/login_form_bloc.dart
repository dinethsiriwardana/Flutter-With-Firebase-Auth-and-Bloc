import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(LoginFormInitial()) {
    on<LoginFormEvent>((event, emit) {
      if (event is FormChangedEvent) {
        emit(FormChangedState(isLogin: !event.isLogin));
      }
    });
  }
}
