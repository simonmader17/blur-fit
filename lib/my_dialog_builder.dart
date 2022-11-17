import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'constants.dart';
import 'my_widgets.dart';

Widget myDialogBuilder(
    BuildContext context, int sourceResolution, Function onPressed) {
  int deviceResolution =
      ui.window.physicalSize.width > ui.window.physicalSize.height
          ? ui.window.physicalSize.height.round()
          : ui.window.physicalSize.width.round();

  Map<String, int> resolutions = {
    "${sourceResolution}p (Source)": sourceResolution,
    "${deviceResolution}p (Device)": deviceResolution,
    "2160p": 2160,
    "1440p": 1440,
    "1080p": 1080,
    "720p": 720,
    "480p": 480
  };
  int selectedResolution = sourceResolution;

  return StatefulBuilder(
    builder: (context, setState) => AlertDialog(
      backgroundColor: const Color(0xff171717),
      titleTextStyle: const TextStyle(
          color: Colors.white, fontFamily: APP_FONT, fontSize: 32),
      contentTextStyle: const TextStyle(
          color: Colors.white, fontFamily: APP_FONT, fontSize: 27),
      title: const Text("Options"),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Resolution:"),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: resolutions.keys.map((title) {
                  if (!title.contains("Source") &&
                      !title.contains("Device") &&
                      (resolutions[title] == sourceResolution ||
                          resolutions[title] == deviceResolution)) {
                    return Container();
                  }
                  return MyCheckbox(
                    title: title,
                    value: resolutions[title]!,
                    selected: selectedResolution == resolutions[title],
                    onClick: () {
                      setState(() {
                        selectedResolution = resolutions[title]!;
                      });
                    },
                  );
                }).toList()),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: const [
                Icon(Icons.info, size: 20, color: Colors.grey),
                SizedBox(width: 6),
                Flexible(
                  child: Text(
                      "If the saved image is blank or corrupted in any way, try a lower resolution.",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ),
              ],
            )
          ]),
      actions: [
        MyGenerateImageButton(onPressed: () {
          onPressed(selectedResolution);
        })
      ],
      actionsAlignment: MainAxisAlignment.center,
    ),
  );
}

class MyGenerateImageButton extends StatefulWidget {
  const MyGenerateImageButton({super.key, this.onPressed});

  final Function? onPressed;

  @override
  State<MyGenerateImageButton> createState() => _MyGenerateImageButtonState();
}

class _MyGenerateImageButtonState extends State<MyGenerateImageButton> {
  List<Widget> children = [
    const Text(
      "Generate Image",
      style: TextStyle(fontSize: 27),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: () {
        setState(() {
          children = const [
            Text("Generating", style: TextStyle(fontSize: 27)),
            SizedBox(width: 10),
            CircularProgressIndicator(color: Colors.white)
          ];
        });
        if (widget.onPressed != null) widget.onPressed!();
      },
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children),
    );
  }
}
