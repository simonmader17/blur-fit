import 'package:blur_fit/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'image_editor.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key});

  Future<void> _pickImage(BuildContext context) async {
    File imageFile;

    XFile? selected =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selected == null) {
      return;
    }
    imageFile = File(selected.path);

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageEditor(imageFile)));
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
            body: Center(
                child: MyButton(
                    onPressed: () {
                      _pickImage(context);
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
