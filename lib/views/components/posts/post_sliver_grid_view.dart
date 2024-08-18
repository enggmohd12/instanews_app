import 'package:flutter/material.dart';
import 'package:instanews_app/state/posts/models/post.dart';
import 'package:instanews_app/views/components/posts/post_thumbnail_view.dart';
import 'package:instanews_app/views/post_details/post_details_view.dart';

class PostSliverGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostSliverGridView({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(childCount: posts.length,
          (context, index) {
        final post = posts.elementAt(index);
        return PostThumbailView(
          post: post,
          onTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostDetailView(
                        post: post,
                      )),
            );
          },
        );
      }),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
    );
  }
}
