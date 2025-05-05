import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_tuition_tracker/database/user_database.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordInitial()) {
    on<ForgetPasswordInitialEvent>(_onForgetPasswordInitial);
    on<ResetPasswordButtonClickedEvent>(_onResetPasswordButtonClickedEvent);
    on<ForgetPasswordNavigateToLogIn>(_onForgetPasswordNavigateToLogIn);
  }

  FutureOr<void> _onForgetPasswordInitial(
    ForgetPasswordInitialEvent event,
    Emitter<ForgetPasswordState> emit,
  ) {
    emit(ForgetPasswordLoaded());
  }

  FutureOr<void> _onResetPasswordButtonClickedEvent(
    ResetPasswordButtonClickedEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(ForgetPasswordLoading());
    try {
      final db = Authentication();
      await db.resetPassword(event.email);
      emit(ForgetPasswordSuccess());
      emit(ForgetPasswordLoaded());
    } catch (e) {
      emit(ForgetPasswordFailure(error: e.toString()));
    }
  }

  FutureOr<void> _onForgetPasswordNavigateToLogIn(
    ForgetPasswordNavigateToLogIn event,
    Emitter<ForgetPasswordState> emit,
  ) {
    emit(ForgetPasswordNavigateToLogInState());
  }
}
