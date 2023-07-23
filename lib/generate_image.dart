import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

Future<Uint8List> generateImage(
    RenderRepaintBoundary imageBoundary,
    File imageSource,
    double aspectRatio,
    int destRes,
    Function onSuccess) async {
  try {
    if (destRes <= 0) {
      var decodedImage =
          await decodeImageFromList(imageSource.readAsBytesSync());
      destRes = decodedImage.width > decodedImage.height
          ? decodedImage.height
          : decodedImage.width;
    }

    double pixelRatio = destRes /
        (aspectRatio >= 1
            ? imageBoundary.size.height
            : imageBoundary.size
                .width); // pick pixelRatio so, that the images smaller side is equal to destRes
    print(pixelRatio);
    ui.Image image = await imageBoundary.toImage(pixelRatio: pixelRatio);
    ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
    var pngBytes = byteData.buffer.asUint8List();
    var bs64 = base64Encode(pngBytes);
    print(pngBytes);
    print(bs64);

    int timestamp = DateTime.now().millisecondsSinceEpoch;
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String fdatetime = DateFormat("yyyyMMdd-HHmmss").format(tsdate);
    String tmpDir = (await getTemporaryDirectory()).path;
    String filePath = "$tmpDir/blur-fit-$fdatetime.jpg";
    File file = File(filePath);
    file.writeAsBytesSync(pngBytes);
    GallerySaver.saveImage(filePath, albumName: "Blur Fit");
    print("$filePath saved");

    onSuccess();

    return pngBytes;
  } catch (e) {
    // print(e);
    rethrow;
  }
}
