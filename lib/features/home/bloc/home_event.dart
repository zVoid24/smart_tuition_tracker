part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {
  final String role;
  HomeInitialEvent({required this.role});
}
