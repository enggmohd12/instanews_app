import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instanews_app/state/auth/constants/firebase_collection_name.dart';
import 'package:instanews_app/state/auth/constants/firebase_field_name.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';
import 'package:instanews_app/state/user_info/models/user_info_payload.dart';
import 'package:instanews_app/state/user_profile/models/user_profile_key.dart';
import 'package:instanews_app/state/user_profile/models/user_profile_payload.dart';

class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          //FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? '',
        });

        return true;
      }

      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
      );

      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .add(
            payload,
          );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveUserProfile(
      {required UserId userId, required String displayName}) async {
    try {
      final userprofile = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.usersprofile,
          )
          .where(
            UserProfileKey.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();
      if (userprofile.docs.isNotEmpty) {
        return true;
      }

      final userprofilepayload = UserProfilePayload(
        userId: userId,
        bio: '',
        fileUrl: 'NA',
        fileName: 'NA',
        profileImageStorageId: '',
        displayName: displayName,
      );

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.usersprofile)
          .add(
            userprofilepayload,
          );

      return true;
    } catch (_) {
      return false;
    }
  }
}
