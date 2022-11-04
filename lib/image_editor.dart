import 'dart:io';
import 'dart:ui' as ui show Image;

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  // final ui.Image? image;

  MyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = Colors.indigo;
    canvas.drawRect(Rect.fromLTWH(20, 40, 100, 100), paint);

    // canvas.drawImage(image!, Offset(0, -400), Paint());
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
}

class ImageEditor extends StatefulWidget {
  const ImageEditor(this.imageFile, {super.key});

  final File imageFile;

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  double _aspectRatio = 1 / 2;
  double _borderRadius = 0;
  double _inset = 0;

  // ui.Image? _uiImage;

  // void convertImage() {
  //   widget.imageFile.readAsBytes().then((bytes) async {
  //     final image = await decodeImageFromList(bytes);
  //     setState(() {
  //       _uiImage = image;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(17),
      child: Column(
        children: [
          AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff212121),
                      borderRadius: BorderRadius.circular(18)),
                  child: Column(children: [
                    Expanded(
                        child: Center(
                            child: AspectRatio(
                                aspectRatio: _aspectRatio,
                                child: Container(
                                    decoration: BoxDecoration(),
                                    child:
                                        CustomPaint(painter: MyPainter()))))),
                  ]))),
          SizedBox(height: 17),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Column(
                    children: [
                      Slider(
                        value: _aspectRatio,
                        max: 5,
                        min: 0.1,
                        label: _aspectRatio.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _aspectRatio = value;
                          });
                        },
                      ),
                      Text(widget.imageFile.toString())
                    ],
                  ))),
        ],
      ),
    );
    // return SafeArea(
    //   child: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         AspectRatio(
    //           aspectRatio: 1 / 1,
    //           child: Container(
    //               decoration: BoxDecoration(
    //                   color: Color(0xff212121),
    //                   borderRadius: BorderRadius.circular(18)),
    //               child: AspectRatio(
    //                 aspectRatio: 1 / 2,
    //                 child: Container(
    //                     margin: EdgeInsets.all(20),
    //                     child: Image.file(widget.imageFile)),
    //               )),
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             MyCheckbox(child: Text("1:2")),
    //             MyCheckbox(child: Text("9:16")),
    //             MyCheckbox(child: Text("2:3"))
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}

// class MyCheckbox extends StatelessWidget {
//   const MyCheckbox({super.key, required this.child});

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1 / 1,
//       child: Container(
//           margin: EdgeInsets.only(left: 17),
//           decoration: BoxDecoration(
//               color: Color(0xff212121),
//               borderRadius: BorderRadius.circular(18)),
//           child: child),
//     );
//   }
// }
