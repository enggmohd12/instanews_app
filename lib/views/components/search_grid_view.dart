import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/posts/providers/post_by_search_term_provider.dart';
import 'package:instanews_app/state/posts/typedef/search_term.dart';
import 'package:instanews_app/views/components/animations/data_not_found_animation_view.dart';
import 'package:instanews_app/views/components/animations/globe_animation_text_view.dart';
import 'package:instanews_app/views/components/animations/small_error_animation_view.dart';
import 'package:instanews_app/views/components/posts/post_sliver_grid_view.dart';
import 'package:instanews_app/views/constant/strings.dart';


class SearchGridView extends ConsumerWidget {
  final SearchTerm searchTerm;
  const SearchGridView({
    super.key,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: GlobeAnimationTextView(
          text: Strings.enterYourSearchTerm,
        ),
      );
    }
    final post = ref.watch(postsBySearchTerm(searchTerm));
    return post.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const SliverToBoxAdapter(child: DataNotFoundAnimationView());
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
