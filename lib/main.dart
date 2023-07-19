import 'package:flutter/material.dart';
import 'package:test_app/calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
        title: "Test app",
        theme: ThemeData(
          primaryColor: Colors.blue,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        // ignore: prefer_const_constructors
        home: CalculatorApp());
  }
}
