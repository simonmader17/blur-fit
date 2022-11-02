import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blur Fit',
      theme: ThemeData(
          fontFamily: ,
          scaffoldBackgroundColor: Colors.grey[900],
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(20)))),
      home: const MyStartingScreen(),
    );
  }
}

class MyStartingScreen extends StatelessWidget {
  const MyStartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: TextButton(
      onPressed: () {},
      child: const Text("Import Image"),
    )));
  }
}
