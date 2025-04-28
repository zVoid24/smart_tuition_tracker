import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginInitialEvent>(_onLoginInitialEvent);
    on<LoginNavigateToSignUpButtonClicked>(_LoginNavigateToSignUpButtonClicked);
  }

  FutureOr<void> _onLoginInitialEvent(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginPageLoadedState());
  }

  FutureOr<void> _LoginNavigateToSignUpButtonClicked(
    LoginNavigateToSignUpButtonClicked event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginNavigateToSignUp());
  }
}
