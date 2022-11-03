import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  // Active image file
  File? _imageFile;

  Future<void> _pickImage() async {
    XFile? selected =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selected == null) {
      return;
    }
    setState(() {
      _imageFile = File(selected.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_imageFile != null) {
      return ImageEditor(_imageFile!);
    }
    return Center(
        child: Container(
            decoration: const BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: TextButton(
              onPressed: () {
                _pickImage();
              },
              child: const Text("Import Image"),
            )));
  }
}

class ImageEditor extends StatefulWidget {
  const ImageEditor(this.imageFile, {super.key});

  final File imageFile;

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.file(widget.imageFile),
    );
  }
}
