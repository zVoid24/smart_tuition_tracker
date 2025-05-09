part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenState {}

abstract class HomeScreenActionState extends HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoadedState extends HomeScreenState {
  final UserInformation data;
  HomeScreenLoadedState({required this.data});
}

class HomeScreenLoadingState extends HomeScreenState {}

class HomeScreenLogOutFailure extends HomeScreenActionState {
  final String error;
  HomeScreenLogOutFailure({required this.error});
}

class HomeScreenNavigateToProfileSettingsState extends HomeScreenActionState{}