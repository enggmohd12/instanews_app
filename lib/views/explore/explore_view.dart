import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/posts/providers/all_posts_provider.dart';
import 'package:instanews_app/views/components/animations/globe_animation_text_view.dart';
import 'package:instanews_app/views/components/animations/small_error_animation_view.dart';
import 'package:instanews_app/views/components/posts/post_gridview.dart';
import 'package:instanews_app/views/constant/strings.dart';

class ExploreView extends ConsumerWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'InstaNews',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () {
            ref.refresh(allPostProvider);
            return Future.delayed(const Duration(seconds: 1));
          },
          child: posts.when(
            data: (posts) {
              if (posts.isEmpty) {
                return const GlobeAnimationTextView(
                  text: Strings.noPostsAvailable,
                );
              } else {
                return PostGridView(
                  posts: posts,
                );
              }
            },
            error: (error, stackTrace) => const SmallErrorAnimationView(),
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
