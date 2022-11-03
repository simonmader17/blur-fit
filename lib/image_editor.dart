import 'dart:io';

import 'package:flutter/material.dart';

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
