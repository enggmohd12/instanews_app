import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/posts/providers/user_post_provider.dart';
import 'package:instanews_app/views/components/animations/error_animation_view.dart';
import 'package:instanews_app/views/components/animations/globe_animation_text_view.dart';
import 'package:instanews_app/views/components/animations/loading_animation_view.dart';
import 'package:instanews_app/views/components/posts/post_gridview.dart';

class UserPostView extends ConsumerWidget {
  const UserPostView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(
      userPostProvider,
    );
    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(
          userPostProvider,
        );

        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const GlobeAnimationTextView(text: 'No posts');
          } else {
            return PostGridView(
              posts: posts,
            );
          }
        },
        error: (error, stackTrace) {
          return const ErrorContentsAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
    );
  }
}
