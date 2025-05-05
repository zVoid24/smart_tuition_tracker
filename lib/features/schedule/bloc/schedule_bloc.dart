import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_tuition_tracker/database/teacher_database.dart';
import 'package:smart_tuition_tracker/models/dayschedule.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial()) {
    on<ScheduleInitialEvent>(_onScheduleInitialEvent);
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
      print(dayToInt);
      emit(ScheduleLoadedState(schedules: schedules ?? [], weekDay: dayToInt));
    } catch (e) {
      print('Error: $e');
    }
  }
}
