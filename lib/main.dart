import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:smart_tuition_tracker/database/authentication.dart';
import 'package:smart_tuition_tracker/features/wrapper/ui/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await Authentication().signOut();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Wrapper()));
}
