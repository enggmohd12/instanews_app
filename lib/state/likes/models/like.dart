import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:instanews_app/state/auth/constants/firebase_field_name.dart';
import 'package:instanews_app/state/posts/typedef/post_id.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';


@immutable
class Like extends MapView<String, String> {
  Like({
    required PostId postId,
    required UserId likeBy,
    required DateTime date,
  }) : super({
          FirebaseFieldName.postId: postId,
          FirebaseFieldName.userId: likeBy,
          FirebaseFieldName.date: date.toIso8601String(),
        });
}
