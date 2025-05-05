part of 'profile_settings_bloc.dart';

@immutable
abstract class ProfileSettingsState {}

abstract class ProfileSettingsActionState extends ProfileSettingsState {}

class ProfileSettingsInitial extends ProfileSettingsState {}

class ProfileSettingsLoadedState extends ProfileSettingsState {}

class ProfileSettingsLogOutSuccessState extends ProfileSettingsActionState {}
