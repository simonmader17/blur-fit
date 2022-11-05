import 'package:blur_fit/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'image_editor.dart';
import 'main.dart';

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
        child: MyButton(
            onPressed: () {
              _pickImage();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.image, size: 36),
                SizedBox(width: 6),
                Text("Import Image"),
              ],
            )));
  }
}
