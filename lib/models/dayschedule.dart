import 'package:smart_tuition_tracker/models/student_schedule.dart';

class DaySchedule {
  final String day;
  final List<StudentSchedule> students;

  DaySchedule({required this.day, required this.students});

  factory DaySchedule.fromFirestore(String day, Map<String, dynamic> map) {
    List<StudentSchedule> studentList = [];

    map.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        studentList.add(StudentSchedule.fromMap(value));
      }
    });

    return DaySchedule(day: day, students: studentList);
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'students': students.map((e) => e.toMap()).toList(),
    };
  }
}
