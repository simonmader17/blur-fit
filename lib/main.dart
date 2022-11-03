import 'package:blur_fit/starting_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Utility classes and functions
const LinearGradient gradient = LinearGradient(
    begin: Alignment(-1, -1),
    end: Alignment(1, 1),
    colors: [Color(0xffff0000), Color(0xff3300c3)]);

class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, required this.grad, this.style});

  final String text;
  final TextStyle? style;
  final Gradient grad;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) =>
            grad.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: Text(text, style: style));
  }
}

// My widgets
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Blur Fit',
        theme: ThemeData(
            fontFamily: "LilitaOne",
            scaffoldBackgroundColor: const Color(0xff212121),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    textStyle: const TextStyle(
                        fontSize: 32,
                        fontFamily: "LilitaOne",
                        fontWeight: FontWeight.w400),
                    padding: const EdgeInsets.all(20)))),
        home: Scaffold(
          body: SafeArea(
              child: Stack(children: const [
            StartingScreen(),
            Positioned(
              left: 17,
              top: 8,
              child: GradientText("Blur Fit",
                  grad: gradient,
                  style: TextStyle(fontSize: 44, fontFamily: "JotiOne")),
            )
          ])),
        ));
  }
}