import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_tuition_tracker/database/teacher_database.dart';
import 'package:smart_tuition_tracker/models/student_schedule.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial()) {
    on<ScheduleInitialEvent>(_onScheduleInitialEvent);
    on<ScheduleDateClickEvent>(_onScheduleDateClickedEvent);
  }

  FutureOr<void> _onScheduleInitialEvent(
    ScheduleInitialEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoadingState());
    final db = TeacherDatabase();
    List<int> dayToInt = [];

    List<String> days = [];
    try {
      final schedules = await db.fetchSchedules();
      if (schedules != null) {
        for (int i = 0; i < schedules.length; i++) {
          days.add(schedules[i].day);
        }
        print(days);
        // Remove duplicates
        days = days.toSet().toList();
        for (var day in days) {
          switch (day.toLowerCase()) {
            case 'monday':
              dayToInt.add(1);
            case 'tuesday':
              dayToInt.add(2);
            case 'wednesday':
              dayToInt.add(3);
            case 'thursday':
              dayToInt.add(4);
            case 'friday':
              dayToInt.add(5);
            case 'saturday':
              dayToInt.add(6);
            case 'sunday':
              dayToInt.add(7);
          }
        }
      }
      emit(ScheduleLoadedState(weekDay: dayToInt));
    } catch (e) {
      print('Error: $e');
    }
  }

  FutureOr<void> _onScheduleDateClickedEvent(
    ScheduleDateClickEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    //emit(ScheduleLoadingState());
    final db = TeacherDatabase();
    List<int> dayToInt = [];
    List<String> days = [];
    try {
      final schedules = await db.fetchSchedules();
      if (schedules != null) {
        for (int i = 0; i < schedules.length; i++) {
          days.add(schedules[i].day);
        }
        print(days);
        // Remove duplicates
        days = days.toSet().toList();
        for (var day in days) {
          switch (day.toLowerCase()) {
            case 'monday':
              dayToInt.add(1);
            case 'tuesday':
              dayToInt.add(2);
            case 'wednesday':
              dayToInt.add(3);
            case 'thursday':
              dayToInt.add(4);
            case 'friday':
              dayToInt.add(5);
            case 'saturday':
              dayToInt.add(6);
            case 'sunday':
              dayToInt.add(7);
          }
        }
      }
      final Map<int, List<StudentSchedule>> dateClicked = {};
      if (schedules != null) {
        for (var doc in schedules) {
          int x;
          switch (doc.day.toLowerCase()) {
            case 'monday':
              x = 1;
              break;
            case 'tuesday':
              x = 2;
              break;
            case 'wednesday':
              x = 3;
              break;
            case 'thursday':
              x = 4;
              break;
            case 'friday':
              x = 5;
              break;
            case 'saturday':
              x = 6;
              break;
            case 'sunday':
              x = 7;
              break;
            default:
              throw Exception('Invalid day: ${doc.day}');
          }
          dateClicked[x] = doc.students;
        }
      }
      print(dateClicked);
      print(dayToInt);
      final List<StudentSchedule> studentList =
          dateClicked[event.weekDay] ?? [];
      print(studentList);
      emit(ScheduleLoadedState(schedules: studentList, weekDay: dayToInt));
    } catch (e) {
      print('Error: $e');
    }
  }
}
