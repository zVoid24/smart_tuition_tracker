import 'package:flutter/material.dart';
import 'package:smart_tuition_tracker/features/wrapper/ui/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Wrapper());
}
