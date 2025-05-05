import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_tuition_tracker/database/user_database.dart';

part 'profile_settings_event.dart';
part 'profile_settings_state.dart';

class ProfileSettingsBloc
    extends Bloc<ProfileSettingsEvent, ProfileSettingsState> {
  ProfileSettingsBloc() : super(ProfileSettingsInitial()) {
    on<ProfileSettingsInitialEvent>(_onProfileSettingsInitialEvent);
    on<ProfileSettingsLogOutEvent>(_onProfileSettingsLogOutEvent);
  }

  FutureOr<void> _onProfileSettingsInitialEvent(
    ProfileSettingsInitialEvent event,
    Emitter<ProfileSettingsState> emit,
  ) {
    emit(ProfileSettingsLoadedState());
  }

  FutureOr<void> _onProfileSettingsLogOutEvent(
    ProfileSettingsLogOutEvent event,
    Emitter<ProfileSettingsState> emit,
  ) async {
    final db = Authentication();
    try {
      await db.logOut();
      emit(ProfileSettingsLogOutSuccessState());
    } catch (e) {}
  }
}
