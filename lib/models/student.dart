class Student {
  final String name;
  final String email;
  Student({required this.name, required this.email});
  factory Student.fromFirestore(Map<String, dynamic> data) {
    return Student(name: data['name'] ?? '', email: data['email'] ?? '');
  }
}
