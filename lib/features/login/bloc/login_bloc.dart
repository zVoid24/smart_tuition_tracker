import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_tuition_tracker/database/user_database.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginInitialEvent>(_onLoginInitialEvent);
    on<LoginNavigateToSignUpButtonClicked>(_LoginNavigateToSignUpButtonClicked);
    on<LoginButtonClickedEvent>(_onLoginButtonClickedEvent);
    on<LoginNavigateToForgetPasswordEvent>(
      _onLoginNavigateToForgetPasswordEvent,
    );
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

  FutureOr<void> _onLoginButtonClickedEvent(
    LoginButtonClickedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    final db = Authentication();
    try {
      await db.signInWithEmail(
        email: event.email,
        password: event.password,
        rememberMe: event.rememberMe,
      );
      debugPrint("Logged in");
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _onLoginNavigateToForgetPasswordEvent(
    LoginNavigateToForgetPasswordEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginNavigateToForgetPasswordState());
  }
}
