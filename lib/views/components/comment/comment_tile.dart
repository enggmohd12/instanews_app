import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/providers/user_id_provider.dart';
import 'package:instanews_app/state/comment/models/comments.dart';
import 'package:instanews_app/state/comment/providers/delete_comment_provider.dart';
import 'package:instanews_app/state/user_info/providers/user_info_providers.dart';
import 'package:instanews_app/views/components/animations/small_error_animation_view.dart';
import 'package:instanews_app/views/components/constant/strings.dart';
import 'package:instanews_app/views/components/dialogbox/alert_model_dialog.dart';
import 'package:instanews_app/views/components/dialogbox/delete_dialog.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  const CommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider(comment.fromuserId));
    return userInfo.when(
      data: (userInfoModel) {
        final currentUserId = ref.read(userIdProvider);
        return ListTile(
          trailing: currentUserId == comment.fromuserId
              ? IconButton(
                  onPressed: () async {
                    final shouldDelete = await displayDeleteDialog(context);
                    if (shouldDelete) {
                      await ref.read(deleteCommentProvider.notifier).deleteComment(
                            commentId: comment.id,
                          );
                    }
                  },
                  icon: const Icon(Icons.delete))
              : null,
          title: Text(userInfoModel.displayName),
          subtitle: Text(comment.comment),
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<bool> displayDeleteDialog(BuildContext context) =>
     const DeleteDialog(titleOfObjectToDelete: Strings.comment)
          .present(context)
          .then((value) => value ?? false);
}
