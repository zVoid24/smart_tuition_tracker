import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:smart_tuition_tracker/database/authentication.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpInitialEvent>(_onSignUpInitialEvent);
    on<SignUpButtonClicked>(_onSignUpButtonClicked);
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
  ) {
    emit(SignUpLoadingState());
    try {
      final db = Authentication();
      debugPrint(event.role + 'delulu');
      db.signUp(event.email, event.password, event.name, event.role);
      print('Success');
      emit(SignUpSuccessState());
    } catch (e) {
      emit(SignUpFailureState(error: e.toString()));
    }
  }
}
