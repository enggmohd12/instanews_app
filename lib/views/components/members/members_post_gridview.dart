import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/posts/providers/member_post_provider.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';
import 'package:instanews_app/views/components/animations/globe_animation_text_view.dart';
import 'package:instanews_app/views/components/animations/small_error_animation_view.dart';
import 'package:instanews_app/views/components/posts/post_sliver_grid_view.dart';

class MemberGridView extends ConsumerWidget {
  final UserId memberPostUserId;
  const MemberGridView({
    super.key,
    required this.memberPostUserId,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final posts = ref.watch(memberpostProvider(memberPostUserId));
    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const SliverToBoxAdapter(
              child: GlobeAnimationTextView(
            text: 'No post',
          ));
        } else {
          return PostSliverGridView(
            posts: posts,
          );
        }
      },
      error: (error, stackTrace) =>
          const SliverToBoxAdapter(child: SmallErrorAnimationView()),
      loading: () => const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
