class StudentSchedule {
  final String name;
  final String time;

  StudentSchedule({
    required this.name,
    required this.time,
  });

  factory StudentSchedule.fromMap(Map<String, dynamic> map) {
    return StudentSchedule(
      name: map['name'] ?? '',
      time: map['time'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'time': time,
    };
  }
}
