import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instanews_app/state/auth/constants/firebase_field_name.dart';
import 'package:instanews_app/state/comment/typedef/comment_id.dart';
import 'package:instanews_app/state/posts/typedef/post_id.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';

@immutable
class Comment {
  final CommentId id;
  final String comment;
  final DateTime createdAt;
  final UserId fromuserId;
  final PostId onpostId;

  // const Comment({
  //   required this.commentId,
  //   required this.comment,
  //   required this.createdAt,
  //   required this.userId,
  //   required this.postId,
  // });

  Comment(Map<String,dynamic> json, {required this.id}):
  comment= json[FirebaseFieldName.comment],
  createdAt= (json[FirebaseFieldName.createdAt] as Timestamp).toDate(),
  fromuserId= json[FirebaseFieldName.userId],
  onpostId= json[FirebaseFieldName.postId];

    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          comment == other.comment &&
          createdAt == other.createdAt &&
          fromuserId == other.fromuserId &&
          onpostId == other.onpostId;

  @override
  int get hashCode => Object.hashAll(
        [
          id,
          comment,
          createdAt,
          fromuserId,
          onpostId,
        ],
      );
}
