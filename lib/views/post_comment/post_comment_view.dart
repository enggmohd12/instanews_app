import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instanews_app/state/auth/providers/user_id_provider.dart';
import 'package:instanews_app/state/comment/models/posts_comment_request.dart';
import 'package:instanews_app/state/comment/providers/post_comment_provider.dart';
import 'package:instanews_app/state/comment/providers/send_comment_provider.dart';
import 'package:instanews_app/state/posts/typedef/post_id.dart';
import 'package:instanews_app/views/components/animations/empty_animation_with_text_view.dart';
import 'package:instanews_app/views/components/animations/error_animation_view.dart';
import 'package:instanews_app/views/components/animations/globe_animation_text_view.dart';
import 'package:instanews_app/views/components/animations/globe_animation_view.dart';
import 'package:instanews_app/views/components/animations/loading_animation_view.dart';
import 'package:instanews_app/views/components/comment/comment_tile.dart';
import 'package:instanews_app/views/constant/strings.dart';
import 'package:instanews_app/views/extensions/dismiss_keyboard.dart';


class PostCommentView extends HookConsumerWidget {
  final PostId postId;
  const PostCommentView({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();

    final hasText = useState(false);

    final request = useState(RequestForPostAndComments(
      postId: postId,
    ));

    final comments = ref.watch(postCommentsProvider(
      request.value,
    ));

    useEffect(() {
      commentController.addListener(() {
        hasText.value = commentController.text.isNotEmpty;
      });
      return () {};
    }, [commentController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.comments),
        actions: [
          IconButton(
              onPressed: hasText.value
                  ? () {
                      _submitCommentController(
                        commentController,
                        ref,
                      );
                    }
                  : null,
              icon: const Icon(Icons.send))
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
                flex: 4,
                child: comments.when(
                  data: (comment) {
                    if (comment.isEmpty) {
                      return const SingleChildScrollView(
                        child: Center(child: GlobeAnimationTextView(text: Strings.noCommentsYet,)),
                      );
                    }
                    return RefreshIndicator(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(
                          8.0,
                        ),
                        itemCount: comment.length,
                        itemBuilder: (context, index) {
                          return CommentTile(comment: comment.elementAt(index));
                        },
                      ),
                      onRefresh: () {
                        ref.refresh(postCommentsProvider(
                          request.value,
                        ));
                        return Future.delayed(
                          const Duration(
                            seconds: 1,
                          ),
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) =>
                      const ErrorContentsAnimationView(),
                  loading: () => const LoadingAnimationView(),
                )),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextField(
                    textInputAction: TextInputAction.send,
                    controller: commentController,
                    onSubmitted: (comment) {
                      if (comment.isNotEmpty) {
                        _submitCommentController(
                          commentController,
                          ref,
                        );
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: Strings.writeYourCommentHere),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentController(
    TextEditingController controller,
    WidgetRef ref,
  ) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }

    final isSent = await ref
        .read(
          sendCommentProvider.notifier,
        )
        .sendComment(
          fromUserId: userId,
          onPostId: postId,
          comment: controller.text.toString(),
        );
    if (isSent) {
      controller.clear();
      dismissKeyboard();
    }
  }
}
