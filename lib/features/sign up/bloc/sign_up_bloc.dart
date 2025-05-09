import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_tuition_tracker/database/user_database.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpInitialEvent>(_onSignUpInitialEvent);
    on<SignUpButtonClicked>(_onSignUpButtonClicked);
    on<SignUpNavigateToLogInEvent>(_onSignUpNavigateToLogInEvent);
  }

  FutureOr<void> _onSignUpInitialEvent(
    SignUpInitialEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(SignUpLoadedState());
  }

  FutureOr<void> _onSignUpButtonClicked(
    SignUpButtonClicked event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoadingState());
    final db = Authentication();
    try {
      emit(SignUpLoadingState());
      debugPrint('${event.role}delulu');
      await db.signUp(event.email, event.password, event.name, event.role);
      print('Success');
      emit(SignUpSuccessState());
    } catch (e) {
      print('Error in signUp: $e');
      emit(SignUpFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _onSignUpNavigateToLogInEvent(
    SignUpNavigateToLogInEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(SignUpNavigateToLogInState());
  }
}
