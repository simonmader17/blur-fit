import 'package:blur_fit/constants.dart';
import 'package:blur_fit/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'image_editor.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  Future<void> _pickImage(
      BuildContext context, void Function(File imageFile) onSuccess) async {
    File imageFile;

    XFile? selected =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selected == null) {
      return;
    }
    imageFile = File(selected.path);

    onSuccess(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
                statusBarColor: const Color(0x00000000),
                systemNavigationBarColor: const Color(0xff171717),
              ),
              title: const Text("Blur Fit",
                  style: TextStyle(
                      fontFamily: APP_BAR_FONT,
                      fontSize: 44,
                      color: Colors.white)),
              flexibleSpace: Container(
                  decoration: const BoxDecoration(gradient: myGradient)),
            ),
            body: Center(
                child: MyButton(
                    onPressed: () {
                      _pickImage(context, (File imageFile) {
                        if (!mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageEditor(imageFile)));
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.image, size: 36),
                        SizedBox(width: 6),
                        Text("Import Image"),
                      ],
                    )))));
  }
}
