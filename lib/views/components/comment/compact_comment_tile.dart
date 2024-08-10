import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/comment/models/comments.dart';
import 'package:instanews_app/state/user_info/providers/user_info_providers.dart';
import 'package:instanews_app/views/components/animations/small_error_animation_view.dart';
import 'package:instanews_app/views/components/rich_two_parts_tex.dart';


class CompactCommentTile extends ConsumerWidget {
  final Comment comment;
  const CompactCommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider(
      comment.fromuserId,
    ));
    return userInfo.when(
      data: (userInfo) {
        return RichTwoPartText(
          rightPart: comment.comment,
          leftPart: userInfo.displayName,
        );
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
