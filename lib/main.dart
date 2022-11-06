import 'package:blur_fit/starting_screen.dart';
import 'package:flutter/material.dart';

import 'my_widgets.dart';

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
            fontFamily: "LilitaOne",
            scaffoldBackgroundColor: const Color(0xff171717),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    textStyle: const TextStyle(
                        fontSize: 32,
                        fontFamily: "LilitaOne",
                        fontWeight: FontWeight.w400),
                    padding: const EdgeInsets.all(20))),
            colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Color(0xffff0000), secondary: Color(0xff3300c3))),
        home: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: AppBar(
              // title: GradientText("Blur Fit",
              //     grad: gradient,
              //     style: TextStyle(fontSize: 44, fontFamily: "JotiOne")),
              // backgroundColor: Color(0xff171717),
              // elevation: 0,
              title: const Text("Blur Fit",
                  style: TextStyle(
                      fontFamily: "JotiOne",
                      fontSize: 44,
                      color: Colors.white)),
              flexibleSpace: Container(
                  decoration: const BoxDecoration(gradient: myGradient)),
            ),
            body: const SafeArea(child: StartingScreen()),
          ),
        ));
  }
}
