import 'package:flutter/material.dart';
import 'package:smart_tuition_tracker/models/student_schedule.dart';

class ScheduleTile extends StatelessWidget {
  final StudentSchedule studentSchedule;
  const ScheduleTile({super.key, required this.studentSchedule});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(studentSchedule.name),
                SizedBox(height: 5),
                Text(studentSchedule.time),
              ],
            ),
            InkWell(onTap: () {}, child: Icon(Icons.message_outlined)),
          ],
        ),
      ),
    );
  }
}
