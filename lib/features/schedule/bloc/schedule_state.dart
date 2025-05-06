part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoadedState extends ScheduleState {
  final List<StudentSchedule> schedules;
  final List<int> weekDay;
  ScheduleLoadedState({this.schedules = const [], required this.weekDay});
}

class ScheduleLoadingState extends ScheduleState {}
