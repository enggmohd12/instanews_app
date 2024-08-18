import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/enums/date_sorting.dart';
import 'package:instanews_app/state/auth/providers/user_id_provider.dart';
import 'package:instanews_app/state/comment/models/posts_comment_request.dart';
import 'package:instanews_app/state/likes/models/like_dislike_request.dart';
import 'package:instanews_app/state/likes/provider/double_tap_like_post_provider.dart';
import 'package:instanews_app/state/likes/provider/like_provider.dart';
import 'package:instanews_app/state/posts/models/post.dart';
import 'package:instanews_app/state/posts/providers/specific_post_with_comment_provider.dart';
import 'package:instanews_app/views/components/animations/loading_animation_view.dart';
import 'package:instanews_app/views/components/animations/small_error_animation_view.dart';
import 'package:instanews_app/views/components/comment/compact_comment_column.dart';

import 'package:instanews_app/views/components/like_button.dart';
import 'package:instanews_app/views/components/likes_count_view.dart';
import 'package:instanews_app/views/components/posts/post_date_view.dart';
import 'package:instanews_app/views/components/posts/post_display_name_and_message_view.dart';
import 'package:instanews_app/views/components/posts/post_image_or_video_view.dart';
import 'package:instanews_app/views/components/posts/post_double_click_like.dart';
import 'package:instanews_app/views/components/posts/post_profile.dart';
import 'package:instanews_app/views/constant/strings.dart';
import 'package:instanews_app/views/post_comment/post_comment_view.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailView extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailView({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends ConsumerState<PostDetailView> {
  static const IconData paperplane = IconData(0xf733, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);


  @override
  Widget build(BuildContext context) {
    // bool check=false;
    final request = RequestForPostAndComments(
      postId: widget.post.postId,
      limit: 3,
      sortByCreatedAt: true,
      dateSorting: DateSorting.oldestOnTop,
    );
    //final a = ref.watch(likeclickprovider);

    // get the actual post together with comments
    final postwithComments = ref.watch(specificPostWithCommentProvider(
      request,
    ));
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.postDetails),
      ),
      body: postwithComments.when(
        data: (postWithComments) {
          final postId = postWithComments.post.postId;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostProfile(
                  postUserId: postWithComments.post.userId,
                  post: postWithComments.post,
                ),
                GestureDetector(
                  onDoubleTap: () {
                    if (postWithComments.post.allowLikes) {
                      final userid = ref.read(userIdProvider);
                      final likerequest =
                          LikeDislikeRequest(postId: postId, likedBy: userid!);
                      ref.read(doublelikePostProvider(
                        likerequest,
                      ));
                      ref.read(likeclickprovider.notifier).state = true;
                      Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          ref.read(likeclickprovider.notifier).state = false;
                        },
                      );
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PostImageOrVideoView(
                        post: postWithComments.post,
                      ),
                      const PostDoubleTapClick()
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (postWithComments.post.allowLikes)
                      LikeButton(
                        postId: postId,
                      ),
                    if (postWithComments.post.allowComments)
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PostCommentView(
                                  postId: postId,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.mode_comment_outlined,
                          )),
                    postwithComments.when(
                      data: (postWithComments) {
                        return IconButton(
                            onPressed: () {
                              final url = postWithComments.post.fileUrl;
                              Share.share(
                                url,
                                subject: Strings.checkOutThisPost,
                              );
                            },
                            icon: const Icon(paperplane));
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
                  ],
                ),
                PostDisplayNameAndMessageView(
                  post: postWithComments.post,
                ),
                PostDateView(
                  dateTime: postWithComments.post.createdAt,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.white70,
                  ),
                ),
                CompactCommentColumn(
                  comment: postWithComments.comments,
                ),
                if (postWithComments.post.allowLikes)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        LikesCountView(
                          postId: postId,
                        ),
                      ],
                    ),
                  ),
                // added spacing in bottom of the screen
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => const SmallErrorAnimationView(),
        loading: () => const LoadingAnimationView(),
      ),
    );
  }
}
