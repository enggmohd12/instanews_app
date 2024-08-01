import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:image_picker/image_picker.dart';
import 'package:instanews_app/state/image_uploads/extensions/to_file.dart';

@immutable
class ImagePickerHandler {
  static final ImagePicker _imagepicker = ImagePicker();

  static Future<File?> pickImageFromGallery() =>
      _imagepicker.pickImage(source: ImageSource.gallery).toFile();

  static Future<File?> pickImageFromCamera() =>
      _imagepicker.pickImage(source: ImageSource.camera).toFile();

  static Future<File?> pickVideoFromCamera() =>
      _imagepicker.pickVideo(source: ImageSource.camera).toFile();

  static Future<File?> pickVideoFromGallery() => 
     _imagepicker.pickVideo(source: ImageSource.gallery).toFile();    
}
