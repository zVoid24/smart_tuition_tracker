import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:smart_tuition_tracker/database/user_database.dart';
import 'package:smart_tuition_tracker/features/wrapper/ui/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await Authentication().signOut();
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.black,
          refreshBackgroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedIconTheme: IconThemeData(color: Colors.black),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          selectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(color: Colors.black),
          unselectedLabelStyle: TextStyle(color: Colors.grey),
        ),
        // Define AppBar color
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, // AppBar background color
          foregroundColor: Colors.black, // AppBar text/icon color
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        // Define Button styles
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Button background color
            foregroundColor: Colors.white, // Button text/icon color
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black, // TextButton text color
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
