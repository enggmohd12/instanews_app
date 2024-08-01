import 'package:flutter/foundation.dart' show immutable;
import 'package:instanews_app/state/auth/constants/firebase_field_name.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';

@immutable
class UserInfo{
  final UserId userId;
  final String email;
  final String displayname;

  UserInfo({required Map<String, dynamic> json})
      : userId = json[FirebaseFieldName.userId],
        email = json[FirebaseFieldName.email],
        displayname = json[FirebaseFieldName.displayName];
}