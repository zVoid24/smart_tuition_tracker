part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadedTeacherState extends HomeState {
  final List<Student> students;
  HomeLoadedTeacherState({required this.students});
}

class HomeLoadedStudentState extends HomeState {}

class HomeLoadingState extends HomeState{}
