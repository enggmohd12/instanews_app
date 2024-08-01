import 'package:flutter/foundation.dart' show immutable;
import 'package:instanews_app/state/posts/typedef/user_id.dart';
import 'package:instanews_app/state/user_profile/models/user_profile_key.dart';

@immutable
class UserProfile {
  final UserId userId;
  final String bio;
  final String fileUrl;
  final String fileName;
  final String profileImageStorageId;
  final String displayName;

  UserProfile({required Map<String, dynamic> json})
      : userId = json[UserProfileKey.userId],
        bio = json[UserProfileKey.bio],
        fileUrl = json[UserProfileKey.fileUrl],
        fileName = json[UserProfileKey.filename],
        profileImageStorageId = json[UserProfileKey.profileImageStorageId],
        displayName = json[UserProfileKey.displayname];
}
