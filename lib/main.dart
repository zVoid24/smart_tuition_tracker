import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:smart_tuition_tracker/database/authentication.dart';
import 'package:smart_tuition_tracker/features/wrapper/ui/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await Authentication().signOut();
  runApp(
    MaterialApp(
      theme: ThemeData(
        // Define AppBar color
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFA12F2F), // AppBar background color
          foregroundColor: Colors.white, // AppBar text/icon color
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        // Define Button styles
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFA12F2F), // Button background color
            foregroundColor: Colors.white, // Button text/icon color
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFFA12F2F), // TextButton text color
          ),
        ),
        // Define Text style
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black), // Default text color
          headlineSmall: TextStyle(color: Colors.black), // For headlines
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    ),
  );
}
