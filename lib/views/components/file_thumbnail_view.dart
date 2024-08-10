import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/image_uploads/models/thumbnail_request.dart';
import 'package:instanews_app/state/image_uploads/providers/thumbnail_provider.dart';
import 'package:instanews_app/views/components/animations/loading_animation_view.dart';
import 'package:instanews_app/views/components/animations/small_error_animation_view.dart';

class FileThumbnailView extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;
  const FileThumbnailView({
    super.key,
    required this.thumbnailRequest,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumnailProvider(thumbnailRequest));
    return thumbnail.when(
      data: (imageAspectRatio) {
        return AspectRatio(
          aspectRatio: imageAspectRatio.aspectRatio,
          child: imageAspectRatio.image,
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const LoadingAnimationView(),
    );
  }
}
