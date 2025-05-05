import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'wrapper_event.dart';
part 'wrapper_state.dart';

class WrapperBloc extends Bloc<WrapperEvent, WrapperState> {
  WrapperBloc() : super(UnAuthenticated()) {
    on<WrapperInitialEvent>(_onWrapperInitialEvent);
  }

  FutureOr<void> _onWrapperInitialEvent(
    WrapperInitialEvent event,
    Emitter<WrapperState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final firebaseAuth = FirebaseAuth.instance;
    final rememberMe = prefs.getBool('remember_me') ?? false;

    if (rememberMe && firebaseAuth.currentUser != null) {
      emit(Authenticated(uid: firebaseAuth.currentUser!.uid));
    } else {
      emit(UnAuthenticated());
    }
  }
}
