part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoadedState extends ScheduleState {
  final List<DaySchedule> schedules;
  final List<int> weekDay;
  ScheduleLoadedState({required this.schedules,required this.weekDay});
}

class ScheduleLoadingState extends ScheduleState {}
