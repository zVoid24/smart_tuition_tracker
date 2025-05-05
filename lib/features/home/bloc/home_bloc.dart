import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_tuition_tracker/database/teacher_database.dart';
import 'package:smart_tuition_tracker/models/student.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_onHomeInitialEvent);
  }

  FutureOr<void> _onHomeInitialEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    print(event.role);
    if (event.role == 'Teacher') {
      final teacherDatabase = TeacherDatabase();
      try {
        final studentList = await teacherDatabase.fetchStudent();
        emit(HomeLoadedTeacherState(students: studentList ?? []));
      } catch (e) {}
    } else {
      emit(HomeLoadedStudentState());
    }
  }
}
