import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/likes/provider/post_like_count_provider.dart';
import 'package:instanews_app/state/posts/typedef/post_id.dart';
import 'package:instanews_app/views/components/animations/small_error_animation_view.dart';
import 'package:instanews_app/views/components/constant/strings.dart';

class LikesCountView extends ConsumerWidget {
  final PostId postId;
  const LikesCountView({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(
      postLikesCountProvider(
        postId,
      ),
    );
    return likesCount.when(
      data: (int likecounts) {
        final personOrPeople = likecounts == 1 ? Strings.person : Strings.people;
        return Text('$likecounts $personOrPeople ${Strings.likedThis}');
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
