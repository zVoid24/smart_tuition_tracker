import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'wrapper_event.dart';
part 'wrapper_state.dart';

class WrapperBloc extends Bloc<WrapperEvent, WrapperState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  WrapperBloc() : super(UnAuthenticated()) {
    _auth.authStateChanges().listen((User? user) {
      add(AuthStateChanged(user: user));
    });
    on<AuthStateChanged>((event, emit) {
      if (event.user != null) {
        emit(Authenticated(uid: event.user!.uid));
      } else {
        emit(UnAuthenticated());
      }
    });
    on<WrapperInitialEvent>(_onWrapperInitialEvent);
  }

  FutureOr<void> _onWrapperInitialEvent(
    WrapperInitialEvent event,
    Emitter<WrapperState> emit,
  ) async{
    final prefs = await SharedPreferences.getInstance();
    final _firebaseAuth = FirebaseAuth.instance;
    final rememberMe = prefs.getBool('remember_me') ?? false;

    if (rememberMe && _firebaseAuth.currentUser != null) {
      emit(Authenticated(uid: _firebaseAuth.currentUser!.uid));
    } else {
      emit(UnAuthenticated());
    }
  }
}
