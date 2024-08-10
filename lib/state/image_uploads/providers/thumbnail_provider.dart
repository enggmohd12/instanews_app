import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/image_uploads/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:instanews_app/state/image_uploads/extensions/get_image_aspect_ratio.dart';
import 'package:instanews_app/state/image_uploads/models/file_type.dart';
import 'package:instanews_app/state/image_uploads/models/image_with_aspect_ratio.dart';
import 'package:instanews_app/state/image_uploads/models/thumbnail_request.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter/material.dart';

final thumnailProvider =
    FutureProvider.family.autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
  (ref, ThumbnailRequest request) async{
    final Image image;

  switch (request.fileType) {
    case FileType.image:
      image = Image.file(
        request.file,
        fit: BoxFit.fitHeight,
      );
      break;

    case FileType.video:
      final thumb = await VideoThumbnail.thumbnailData(
        video: request.file.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );
      if (thumb == null) {
        throw const CouldNotBuildThumbnailException();
      }
      image = Image.memory(
        thumb,
        fit: BoxFit.fitHeight,
      );
      break;
  }

  final aspectRatio = await image.getAspectRatio();
  return ImageWithAspectRatio(
    image: image,
    aspectRatio: aspectRatio,
  );
  },
);
