import 'package:flutter/foundation.dart' show Uint8List;
import 'package:flutter/material.dart' as material show Image;
import 'package:instanews_app/state/image_uploads/extensions/get_image_aspect_ratio.dart';


extension GetImageDataAspectRatio on Uint8List{
  Future<double> getAspectRatio(){
    final image = material.Image.memory(this);
    return image.getAspectRatio();
  }
}