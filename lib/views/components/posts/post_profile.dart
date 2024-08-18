import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/posts/models/post.dart';
import 'package:instanews_app/state/posts/providers/can_current_user_delete_post_provider.dart';
import 'package:instanews_app/state/posts/providers/delete_post_provider.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';
import 'package:instanews_app/state/user_profile/provider/user_post_profile.dart';
import 'package:instanews_app/views/components/animations/small_error_animation_view.dart';
import 'package:instanews_app/views/components/dialogbox/alert_model_dialog.dart';
import 'package:instanews_app/views/components/dialogbox/delete_dialog.dart';
import 'package:instanews_app/views/constant/strings.dart';
import 'package:instanews_app/views/members/member_profile_view.dart';

class PostProfile extends ConsumerStatefulWidget {
  final UserId postUserId;
  final Post post;
  const PostProfile({
    super.key,
    required this.postUserId,
    required this.post,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostProfileState();
}

class _PostProfileState extends ConsumerState<PostProfile> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(userprofilePostProvider(widget.postUserId));
    final canDeletePost =
        ref.watch(canCurrentUserDeletePostProvider(widget.post));
    return data.when(
      data: (data) {
        if (data.isEmpty) {
          return const Text('No data');
        }
        return SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 17,
                          child: data.first.fileUrl != 'NA'
                              ? ClipOval(
                                  child: Image.network(
                                  data.first.fileUrl,
                                  height: 44,
                                  width: 44,
                                  fit: BoxFit.fill,
                                ))
                              : const Icon(
                                  Icons.person,
                                  size: 17,
                                ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MemberProfileView(
                            postUserId: widget.postUserId,
                          ),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.first.displayName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                canDeletePost.when(
                  data: (data) {
                    if (data) {
                      return IconButton(
                          onPressed: () async {
                            final shouldDeletePost = await const DeleteDialog(
                              titleOfObjectToDelete: Strings.post,
                            )
                                .present(context)
                                .then((shouldDelete) => shouldDelete ?? false);

                            if (shouldDeletePost) {
                              await ref
                                  .read(deletePostProvider.notifier)
                                  .deletePost(
                                    post: widget.post,
                                  );
                              if (mounted) {
                                Navigator.of(context).pop();
                              }
                            }
                          },
                          icon: const Icon(Icons.delete_outlined));
                    } else {
                      return const SizedBox();
                    }
                  },
                  error: (error, stackTrace) => const SmallErrorAnimationView(),
                  loading: () => const CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
