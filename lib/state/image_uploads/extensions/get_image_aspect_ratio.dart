import 'dart:async' show Completer;

import 'package:flutter/material.dart' as material
    show Image, ImageConfiguration, ImageStreamListener;

extension GetImageAspectRatio on material.Image {
  Future<double> getAspectRatio() async {
    final completer = Completer<double>();
    image
        .resolve(const material.ImageConfiguration())
        .addListener(material.ImageStreamListener(
      (imageinfo, synchronousCall) {
        final aspectRatio = imageinfo.image.width / imageinfo.image.height;
        imageinfo.image.dispose();
        completer.complete(aspectRatio);
      },
    ));
    return completer.future;
  }
}
