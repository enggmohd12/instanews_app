import 'dart:collection';

import 'package:instanews_app/state/posts/typedef/user_id.dart';
import 'package:instanews_app/state/user_profile/models/user_profile_key.dart';

class UserProfilePayload extends MapView<String, dynamic> {
  UserProfilePayload({
    required UserId userId,
    required String bio,
    required String fileUrl,
    required String fileName,
    required String profileImageStorageId,
    required String displayName,
  }) : super({
          UserProfileKey.userId: userId,
          UserProfileKey.bio: bio,
          UserProfileKey.fileUrl: fileUrl,
          UserProfileKey.filename: fileName,
          UserProfileKey.profileImageStorageId: profileImageStorageId,
          UserProfileKey.displayname : displayName
        });
}
