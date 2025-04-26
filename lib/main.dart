import 'package:flutter/material.dart';
import 'package:smart_tuition_tracker/home screen/ui/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomeScreen());
}
