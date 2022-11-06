import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:blur_fit/main.dart';
import 'package:blur_fit/my_widgets.dart';
import 'package:blur_fit/starting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageEditor extends StatefulWidget {
  const ImageEditor(this.imageFile, {super.key});

  final File imageFile;

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  double _aspectRatio = 1 / 2;
  double _blurIntensity = 3;
  double _borderRadius = 0;
  double _inset = 0;

  final GlobalKey _globalKey = new GlobalKey();

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      print(widget.imageFile);
      RenderRepaintBoundary boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 10.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);

      int timestamp = DateTime.now().millisecondsSinceEpoch;
      DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
      String fdatetime = DateFormat("yyyy-mm-dd_HHmms").format(tsdate);
      print(fdatetime);
      await ImageGallerySaver.saveImage(pngBytes, name: fdatetime);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Saved to gallery")));

      return pngBytes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(17),
      child: Column(
        children: [
          AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [myBoxShadow]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Stack(children: [
                    Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff212121),
                            borderRadius: BorderRadius.circular(0)),
                        child: Column(children: [
                          Expanded(
                              child: Center(
                                  child: RepaintBoundary(
                            key: _globalKey,
                            child: Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: _aspectRatio,
                                  child: ClipRRect(
                                    child: ImageFiltered(
                                        imageFilter: ui.ImageFilter.blur(
                                            sigmaX: _blurIntensity,
                                            sigmaY: _blurIntensity),
                                        child: Image.file(widget.imageFile,
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: _aspectRatio,
                                  child: FittedBox(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: FileImage(
                                                    widget.imageFile))),
                                        child: Image.file(widget.imageFile,
                                            fit: BoxFit.contain)),
                                  ),
                                ),
                              ],
                            ),
                          )))
                        ])),
                    Positioned(
                        right: 20,
                        bottom: 20,
                        child: MyButton(
                          onPressed: () {
                            _capturePng();
                          },
                          child: const Icon(Icons.download),
                        )),
                    Positioned(
                        left: 20,
                        bottom: 20,
                        child: MyButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const MyApp()));
                            },
                            child: const Icon(Icons.refresh)))
                  ]),
                ),
              )),
          const SizedBox(height: 17),
          Expanded(
              child: Container(
                  decoration: const BoxDecoration(),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: MySelectableButton(
                            onPressed: () {
                              setState(() {
                                _aspectRatio = 1 / 2;
                              });
                            },
                            selected: _aspectRatio == 1 / 2,
                            child: const Text("1 : 2",
                                style: TextStyle(fontSize: 25)),
                          )),
                          const SizedBox(
                            width: 17,
                          ),
                          Flexible(
                              child: MySelectableButton(
                            onPressed: () {
                              setState(() {
                                _aspectRatio = 9 / 16;
                              });
                            },
                            selected: _aspectRatio == 9 / 16,
                            child: const Text("9 : 16",
                                style: TextStyle(fontSize: 25)),
                          )),
                          const SizedBox(
                            width: 17,
                          ),
                          Flexible(
                              child: MySelectableButton(
                            onPressed: () {
                              setState(() {
                                _aspectRatio = 1;
                              });
                            },
                            selected: _aspectRatio == 1,
                            child: const Text("1 : 1",
                                style: TextStyle(fontSize: 25)),
                          )),
                        ],
                      ),
                      const SizedBox(height: 17),
                      MySlider(
                        title: "Aspect Ratio",
                        value: _aspectRatio,
                        min: 0.1,
                        max: 5,
                        onChanged: (double value) {
                          setState(() {
                            _aspectRatio = value;
                          });
                        },
                      ),
                      const SizedBox(height: 17),
                      MySlider(
                        title: "Blur Intensity",
                        value: _blurIntensity,
                        min: 0.1,
                        max: 20,
                        onChanged: (double value) {
                          setState(() {
                            _blurIntensity = value;
                          });
                        },
                      ),
                      const SizedBox(height: 17),
                      MySlider(
                        title: "Border Radius",
                        value: _borderRadius,
                        min: 0,
                        max: 20,
                        onChanged: (double value) {
                          setState(() {
                            _borderRadius = value;
                          });
                        },
                      ),
                      const SizedBox(height: 17),
                      MySlider(
                        title: "Inset",
                        value: _inset,
                        min: 0,
                        max: 10,
                        onChanged: (double value) {
                          setState(() {
                            _inset = value;
                          });
                        },
                      ),
                    ],
                  ))),
        ],
      ),
    );
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
