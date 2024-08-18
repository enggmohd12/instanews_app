import 'package:flutter/material.dart';
import 'package:instanews_app/state/image_uploads/models/file_type.dart';
import 'package:instanews_app/state/posts/models/post.dart';
import 'package:instanews_app/views/components/posts/post_image_view.dart';
import 'package:instanews_app/views/components/posts/post_video_view.dart';


class PostImageOrVideoView extends StatelessWidget {
  final Post post;
  const PostImageOrVideoView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    // return (){
    //   if (post.fileType.name == 'image'){
    //     return PostImageView(post: post);
    //   } else{
    //     return PostVideoView(post: post);
    //   }
    // }();
    switch (post.fileType) {
      case FileType.image:
        return PostImageView(
          post: post,
        );
      case FileType.video:
        return PostVideoView(
          post: post,
        );
      default:
        return const SizedBox();
    }
  }
}
