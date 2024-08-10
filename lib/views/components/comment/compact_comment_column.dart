import 'package:flutter/material.dart';
import 'package:instanews_app/state/comment/models/comments.dart';
import 'package:instanews_app/views/components/comment/compact_comment_tile.dart';

class CompactCommentColumn extends StatelessWidget {
  final Iterable<Comment> comment;
  const CompactCommentColumn({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    if (comment.isEmpty) {
      return const SizedBox();
    }
    return Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          bottom: 8.0,
          right: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: comment.map(
            (comment) {
              return CompactCommentTile(
                comment: comment,
              );
            },
          ).toList(),
        ));
  }
}
