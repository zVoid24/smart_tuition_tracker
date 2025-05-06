part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent {}

class ScheduleInitialEvent extends ScheduleEvent {}

class ScheduleDateClickEvent extends ScheduleEvent {
  final int weekDay;
  ScheduleDateClickEvent({required this.weekDay});
}
