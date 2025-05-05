import 'package:flutter/material.dart';
import 'package:smart_tuition_tracker/models/student.dart';

class StudentTile extends StatelessWidget {
  final Student info;
  const StudentTile({super.key, required this.info});

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
                Text(info.name),
                SizedBox(height: 5),
                Text(info.email),
              ],
            ),
            InkWell(onTap: () {}, child: Icon(Icons.message_outlined)),
          ],
        ),
      ),
    );
  }
}
