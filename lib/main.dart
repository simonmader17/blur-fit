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
            MyStartingScreen(),
            Positioned(
                left: 17,
                top: 8,
                child: GradientText("Blur Fit",
                    gradient: LinearGradient(
                        begin: Alignment(-1, -1),
                        end: Alignment(1, 1),
                        colors: [Color(0xffff0000), Color(0xff3300c3)]),
                    style: TextStyle(fontSize: 44, fontFamily: "JotiOne")))
          ])),
        ));
  }
}

class MyStartingScreen extends StatelessWidget {
  const MyStartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(-1, -1),
                    end: Alignment(1, 1),
                    colors: [Color(0xffff0000), Color(0xff3300c3)]),
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: TextButton(
              onPressed: () {},
              child: const Text("Import Image"),
            )));
  }
}

class GradientText extends StatelessWidget {
  const GradientText(this.text,
      {super.key, required this.gradient, this.style});

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => gradient
            .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: Text(text, style: style));
  }
}
