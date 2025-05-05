import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_tuition_tracker/models/dayschedule.dart';
import 'package:smart_tuition_tracker/models/student.dart';

class TeacherDatabase {
  final _teacherCollection = FirebaseFirestore.instance.collection('teacher');

  Future<List<Student>?> fetchStudent() async {
    final firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _teacherCollection
              .doc(user?.uid)
              .collection('student_list')
              .get();

      List<Student> students =
          snapshot.docs.map((doc) {
            return Student.fromFirestore(doc.data());
          }).toList();

      return students;
    } catch (e) {
      print("Error fetching students: $e");
      return [];
    }
  }

  Future<List<DaySchedule>?> fetchSchedules() async {
    final firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;
    try {
    final snapshot =
        await _teacherCollection.doc(user?.uid).collection('schedules').get();

    List<DaySchedule> allSchedules = [];

    for (var doc in snapshot.docs) {
      final dayName = doc.id;
      final data = doc.data();

      final daySchedule = DaySchedule.fromFirestore(dayName, data);
      allSchedules.add(daySchedule);
    }

    return allSchedules;
  } catch (e) {
    print('Error fetching schedules: $e');
    return [];
  }
  }
}
