import 'dart:io';
import 'dart:ui' as ui;
import 'package:blur_fit/constants.dart';
import 'package:blur_fit/my_dialog_builder.dart';
import 'package:flutter/services.dart';
import 'package:blur_fit/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'generate_image.dart';

class ImageEditor extends StatefulWidget {
  const ImageEditor(this.imageFile,
      {super.key, required this.sourceResolution});

  final File imageFile;
  final int sourceResolution;

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  double _aspectRatio = 1;
  double _blurIntensity = 10;
  double _borderRadiusPercentage = 0;
  double _insetPercentage = 0;

  double halfOfImagesSmallestSide =
      ((ui.window.physicalSize.width / 2) / ui.window.devicePixelRatio - 17);

  double _numer = 0;
  double _denum = 0;

  bool _optionsDialogIsOpen = false;
  bool _imageIsGenerating = false;

  final GlobalKey _imagePreviewerKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController numerController = TextEditingController();
  final TextEditingController denumController = TextEditingController();
  void clearTextFields() {
    setState(() {
      _numer = 0;
      _denum = 0;
    });
    numerController.clear();
    denumController.clear();
  }

  void _updateAspectRatio() {
    print("test: $_numer, $_denum");
    if (_numer > 0 && _denum > 0) {
      if (_numer / _denum > 5 || _numer / _denum < 0.1) return;
      print("test2");
      setState(() {
        _aspectRatio = _numer / _denum;
        print(_aspectRatio);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
                statusBarColor: const Color(0x00000000),
                systemNavigationBarColor: const Color(0xff171717),
              ),
              automaticallyImplyLeading: false,
              title: const Text("Blur Fit",
                  style: TextStyle(
                      fontFamily: APP_BAR_FONT,
                      fontSize: 44,
                      color: Colors.white)),
              flexibleSpace: Container(
                  decoration: const BoxDecoration(gradient: myGradient)),
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 17),
                        child: const AspectRatio(aspectRatio: 1)),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(17),
                        children: [
                          const SizedBox(
                            height: 17,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: MySelectableButton(
                                onPressed: () {
                                  setState(() {
                                    _aspectRatio = 1;
                                    clearTextFields();
                                  });
                                },
                                selected: _aspectRatio == 1,
                                child: const FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text("1 : 1",
                                      style: TextStyle(fontSize: 25)),
                                ),
                              )),
                              const SizedBox(
                                width: 17,
                              ),
                              Flexible(
                                  child: MySelectableButton(
                                onPressed: () {
                                  if (_aspectRatio == 9 / 19.5) {
                                    setState(() {
                                      _aspectRatio = 19.5 / 9;
                                      clearTextFields();
                                    });
                                  } else {
                                    setState(() {
                                      _aspectRatio = 9 / 19.5;
                                      clearTextFields();
                                    });
                                  }
                                },
                                selected: _aspectRatio == 9 / 19.5 ||
                                    _aspectRatio == 19.5 / 9,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                      _aspectRatio == 19.5 / 9
                                          ? "19.5 : 9"
                                          : "9 : 19.5",
                                      style: const TextStyle(fontSize: 25)),
                                ),
                              )),
                              const SizedBox(
                                width: 17,
                              ),
                              Flexible(
                                  child: MySelectableButton(
                                onPressed: () {
                                  if (_aspectRatio == 1 / 2) {
                                    setState(() {
                                      _aspectRatio = 2;
                                      clearTextFields();
                                    });
                                  } else {
                                    setState(() {
                                      _aspectRatio = 1 / 2;
                                      clearTextFields();
                                    });
                                  }
                                },
                                selected:
                                    _aspectRatio == 1 / 2 || _aspectRatio == 2,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                      _aspectRatio == 2 ? "2 : 1" : "1 : 2",
                                      style: const TextStyle(fontSize: 25)),
                                ),
                              )),
                            ],
                          ),
                          const SizedBox(height: 17),
                          Row(
                            children: [
                              const Text("Custom Aspect Ratio: ",
                                  style: TextStyle(
                                      fontFamily: APP_FONT,
                                      fontSize: 27,
                                      color: Colors.white)),
                              Flexible(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: TextFormField(
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          setState(() {
                                            _numer = 0;
                                          });
                                        } else {
                                          double newNumer = double.parse(value);
                                          if (newNumer <= 0) {
                                            setState(() {
                                              _numer = 0;
                                            });
                                          } else {
                                            setState(() {
                                              _numer = newNumer;
                                            });
                                          }
                                          _updateAspectRatio();
                                        }
                                      },
                                      controller: numerController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 0),
                                          filled: true,
                                          fillColor: const Color(0xff212121),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              borderSide: const BorderSide(
                                                  color: Color(0xff212121))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              borderSide: const BorderSide(
                                                  color: Color(0xff212121)))),
                                      style: const TextStyle(
                                          fontFamily: APP_FONT,
                                          fontSize: 22,
                                          color: Colors.white)),
                                ),
                              ),
                              const Text(" : ",
                                  style: TextStyle(
                                      fontFamily: APP_FONT,
                                      fontSize: 22,
                                      color: Colors.white)),
                              Flexible(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: TextFormField(
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          setState(() {
                                            _denum = 0;
                                          });
                                        } else {
                                          double newDenum = double.parse(value);
                                          if (newDenum <= 0) {
                                            setState(() {
                                              _denum = 0;
                                            });
                                          } else {
                                            setState(() {
                                              _denum = newDenum;
                                            });
                                          }
                                          _updateAspectRatio();
                                        }
                                      },
                                      controller: denumController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 0),
                                          filled: true,
                                          fillColor: const Color(0xff212121),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              borderSide: const BorderSide(
                                                  color: Color(0xff212121))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              borderSide: const BorderSide(
                                                  color: Color(0xff212121)))),
                                      style: const TextStyle(
                                        fontFamily: APP_FONT,
                                        fontSize: 22,
                                        color: Colors.white,
                                      )),
                                ),
                              )
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
                                clearTextFields();
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
                            value: _borderRadiusPercentage,
                            min: 0,
                            max: 1,
                            onChanged: (double value) {
                              setState(() {
                                _borderRadiusPercentage = value;
                              });
                            },
                          ),
                          const SizedBox(height: 17),
                          MySlider(
                            title: "Inset",
                            value: _insetPercentage,
                            min: 0,
                            max: 1,
                            onChanged: (double value) {
                              setState(() {
                                _insetPercentage = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(17, 17, 17, 0),
                  child: AspectRatio(
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
                                    key: _imagePreviewerKey,
                                    child: Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: _aspectRatio,
                                          child: ClipRRect(
                                            child: ImageFiltered(
                                                imageFilter:
                                                    ui.ImageFilter.blur(
                                                        sigmaX: _blurIntensity,
                                                        sigmaY: _blurIntensity),
                                                child: Image.file(
                                                    widget.imageFile,
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        AspectRatio(
                                          aspectRatio: _aspectRatio,
                                          child: Center(
                                              child: Container(
                                            margin: EdgeInsets.all(
                                                halfOfImagesSmallestSide /
                                                    (_aspectRatio >= 1
                                                        ? _aspectRatio
                                                        : 1 / _aspectRatio) *
                                                    _insetPercentage),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  (halfOfImagesSmallestSide -
                                                          halfOfImagesSmallestSide *
                                                              _insetPercentage) /
                                                      (_aspectRatio >= 1
                                                          ? _aspectRatio
                                                          : 1 / _aspectRatio) *
                                                      _borderRadiusPercentage),
                                              child: Image.file(
                                                  widget.imageFile,
                                                  fit: BoxFit.contain),
                                            ),
                                          )),
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
                                    if (_imageIsGenerating) {
                                      ScaffoldMessenger.of(
                                              _scaffoldKey.currentContext!)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Image is generating...")));
                                      return;
                                    }
                                    setState(() {
                                      _optionsDialogIsOpen = true;
                                    });
                                    showDialog(
                                        context: _scaffoldKey.currentContext!,
                                        builder: (context) => myDialogBuilder(
                                                context,
                                                widget.sourceResolution,
                                                (selectedResolution) {
                                              if (_imageIsGenerating) {
                                                return;
                                              }
                                              setState(() {
                                                _imageIsGenerating = true;
                                              });
                                              generateImage(
                                                  _imagePreviewerKey
                                                          .currentContext
                                                          ?.findRenderObject()
                                                      as RenderRepaintBoundary,
                                                  widget.imageFile,
                                                  _aspectRatio,
                                                  selectedResolution, () {
                                                if (!mounted) return;
                                                ScaffoldMessenger.of(
                                                        _scaffoldKey
                                                            .currentContext!)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Saved to gallery")));
                                                setState(() {
                                                  _imageIsGenerating = false;
                                                });
                                                if (_optionsDialogIsOpen) {
                                                  Navigator.of(context).pop();
                                                }
                                              });
                                            })).then((value) {
                                      setState(() {
                                        _optionsDialogIsOpen = false;
                                      });
                                    });
                                  },
                                  child: const Icon(Icons.download),
                                )),
                            Positioned(
                                left: 20,
                                bottom: 20,
                                child: MyButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(Icons.refresh)))
                          ]),
                        ),
                      )),
                ),
              ],
            )));
  }
}
