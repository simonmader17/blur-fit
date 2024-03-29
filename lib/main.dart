import 'package:blur_fit/starting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'Blur Fit',
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: APP_FONT,
          scaffoldBackgroundColor: const Color(0xff171717),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  textStyle: const TextStyle(
                      fontSize: 32,
                      fontFamily: APP_FONT,
                      fontWeight: FontWeight.w400),
                  padding: const EdgeInsets.all(20))),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xffff0000),
              secondary: const Color(0xff3300c3))),
      home: const StartingScreen(),
    );
  }
}
