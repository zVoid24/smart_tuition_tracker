part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenEvent {}

class HomeScreenInitialEvent extends HomeScreenEvent{}

class HomeScreenLogOutEvent extends HomeScreenEvent{}

class HomeScreenNavigateToProfileSettingsEvent extends HomeScreenEvent{}