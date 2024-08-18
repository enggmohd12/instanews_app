import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/providers/user_id_provider.dart';
import 'package:instanews_app/state/likes/models/like_dislike_request.dart';
import 'package:instanews_app/state/likes/provider/has_like_post_provider.dart';
import 'package:instanews_app/state/likes/provider/like_dislike_post_provider.dart';
import 'package:instanews_app/state/posts/typedef/post_id.dart';
import 'package:instanews_app/views/components/animations/small_error_animation_view.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;
  const LikeButton({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(hasLikePostProvider(
      postId,
    ));
    return hasLiked.when(
      data: (hasLiked) {
        return IconButton(
            onPressed: () {
              final userId = ref.read(userIdProvider);
              if (userId == null) {
                return;
              }

              final likeRequest = LikeDislikeRequest(
                postId: postId,
                likedBy: userId,
              );

              ref.read(
                likeDislikePostProvider(
                  likeRequest,
                ),
              );
            },
            icon: hasLiked
                ? Icon(
                    Icons.favorite,
                    color: Colors.purpleAccent.shade400,
                  )
                : const Icon(Icons.favorite_border_outlined));
      },
      error: (error, stackTrace) {
        return const SmallErrorAnimationView();
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
