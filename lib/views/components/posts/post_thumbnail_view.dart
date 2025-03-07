import 'package:flutter/material.dart';
import 'package:instanews_app/state/posts/models/post.dart';

class PostThumbailView extends StatelessWidget {
  final Post post;
  final VoidCallback onTapped;
  const PostThumbailView({
    super.key,
    required this.post,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Image.network(
        post.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
