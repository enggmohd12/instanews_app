import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/posts/models/post.dart';
import 'package:instanews_app/state/user_info/providers/user_info_providers.dart';
import 'package:instanews_app/views/components/animations/small_error_animation_view.dart';
import 'package:instanews_app/views/components/rich_two_parts_tex.dart';


class PostDisplayNameAndMessageView extends ConsumerWidget {
  final Post post;
  const PostDisplayNameAndMessageView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(
      userInfoProvider(
        post.userId,
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: userInfoModel.when(
        data: (userInfoModel) {
          return RichTwoPartText(
            rightPart: post.message,
            leftPart: userInfoModel.displayName,
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
      ),
    );
  }
}
