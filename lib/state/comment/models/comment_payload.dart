import 'dart:collection' show MapView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instanews_app/state/auth/constants/firebase_field_name.dart';
import 'package:instanews_app/state/posts/typedef/post_id.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';


@immutable
class CommentPayload extends MapView<String, dynamic> {
  CommentPayload({
    required UserId fromUserId,
    required PostId onPostId,
    required String comment,
  }) : super({
          FirebaseFieldName.userId: fromUserId,
          FirebaseFieldName.postId: onPostId,
          FirebaseFieldName.comment: comment,
          FirebaseFieldName.createdAt: FieldValue.serverTimestamp(),
        });
}
