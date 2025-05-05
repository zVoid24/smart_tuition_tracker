part of 'profile_settings_bloc.dart';

@immutable
abstract class ProfileSettingsEvent {}

class ProfileSettingsInitialEvent extends ProfileSettingsEvent{}

class ProfileSettingsLogOutEvent extends ProfileSettingsEvent{}