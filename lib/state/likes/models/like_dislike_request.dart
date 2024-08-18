import 'package:flutter/foundation.dart' show immutable;
import 'package:instanews_app/state/posts/typedef/post_id.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';

@immutable
class LikeDislikeRequest {
  final PostId postId;
  final UserId likedBy;

  const LikeDislikeRequest({
    required this.postId,
    required this.likedBy,
  });
}
