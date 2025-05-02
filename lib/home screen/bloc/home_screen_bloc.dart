import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_tuition_tracker/database/authentication.dart';
import 'package:smart_tuition_tracker/models/user.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<HomeScreenInitialEvent>(_onHomeScreenInitialEvent);
    on<HomeScreenLogOutEvent>(_onHomeScreenLogOutEvent);
  }

  FutureOr<void> _onHomeScreenInitialEvent(
    HomeScreenInitialEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(HomeScreenLoadingState());
    final db = Authentication();
    final info = await db.getUserData();
    emit(HomeScreenLoadedState(data: info));
  }

  FutureOr<void> _onHomeScreenLogOutEvent(
    HomeScreenLogOutEvent event,
    Emitter<HomeScreenState> emit,
  ) {
    emit(HomeScreenLoadingState());
    try {
      final db = Authentication();
      db.logOut();
    } catch (e) {
      emit(HomeScreenLogOutFailure(error: e.toString()));
    }
  }
}
