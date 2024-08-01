import 'dart:io';
import 'package:instanews_app/state/auth/constants/firebase_field_name.dart';
import 'package:instanews_app/state/user_profile/models/user_profile_key.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/constants/firebase_collection_name.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';
import 'package:instanews_app/state/user_profile/models/user_profile_payload.dart';
import 'package:instanews_app/state/user_profile/typedef/isloading.dart';

class UserProfileNotifier extends StateNotifier<IsLoading> {
  UserProfileNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> checking({
    required String userId,
    required String bio,
    required String fileName,
    required String filePath,
    required String strorageId,
    required String name,
  }) async {
    final userprofilepayload = UserProfilePayload(
      userId: userId,
      bio: bio,
      fileUrl: filePath,
      fileName: fileName,
      profileImageStorageId: strorageId,
      displayName: name,
    );

    try {
      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.usersprofile,
          )
          .add(
            userprofilepayload,
          );

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> uploadProfileData({
    required UserId userid,
    required String name,
    required File? file,
    required String? bio,
    required String? profileStorageIdOld,
  }) async {
    isLoading = true;

    try {
      final userinfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: userid)
          .limit(1)
          .get();
      if (userinfo.docs.isNotEmpty) {
        await userinfo.docs.first.reference
            .update({FirebaseFieldName.displayName: name});
      }
    } catch (_) {
      return false;
    }

    String profileStorageId = '';
    final fileName = const Uuid().v4();
    if (file != null) {
      try {
        final userprofileinfo = await FirebaseFirestore.instance
            .collection(
              FirebaseCollectionName.usersprofile,
            )
            .where(UserProfileKey.userId, isEqualTo: userid)
            .limit(1)
            .get();

        if (userprofileinfo.docs.isNotEmpty) {
          try {
            if (profileStorageIdOld != '') {
              await FirebaseStorage.instance
                  .ref()
                  .child(userid)
                  .child(FirebaseCollectionName.profilephoto)
                  .child(profileStorageIdOld!)
                  .delete();
            }
          } catch (_) {
            print('Error occured when deleting the file from storage');
          }
          final profileFileRef = FirebaseStorage.instance
              .ref()
              .child(userid)
              .child(FirebaseCollectionName.profilephoto)
              .child(fileName);

          final profileUploadtask = await profileFileRef.putFile(file);
          profileStorageId = profileUploadtask.ref.name;

          await userprofileinfo.docs.first.reference.update({
            UserProfileKey.bio: bio ?? 'NA',
            UserProfileKey.fileUrl: profileStorageId == ''
                ? 'NA'
                : await profileFileRef.getDownloadURL(),
            UserProfileKey.filename: fileName,
            UserProfileKey.profileImageStorageId: profileStorageId,
            UserProfileKey.displayname:name,
          });

          return true;
        }
        final profileFileRef = FirebaseStorage.instance
            .ref()
            .child(userid)
            .child(FirebaseCollectionName.profilephoto)
            .child(fileName);

        final profileUploadtask = await profileFileRef.putFile(file);

        profileStorageId = profileUploadtask.ref.name;
        final userprofilepayload = UserProfilePayload(
          userId: userid,
          bio: bio ?? 'NA',
          fileUrl: profileStorageId == ''
              ? 'NA'
              : await profileFileRef.getDownloadURL(),
          fileName: fileName,
          profileImageStorageId: profileStorageId,
          displayName: name,
        );
        await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.usersprofile)
            .add(
              userprofilepayload,
            );
        return true;
      } catch (_) {
        return false;
      } finally {
        isLoading = false;
      }
    } else {
      try {
        final userprofileinfo = await FirebaseFirestore.instance
            .collection(
              FirebaseCollectionName.usersprofile,
            )
            .where(UserProfileKey.userId, isEqualTo: userid)
            .limit(1)
            .get();

        if (userprofileinfo.docs.isNotEmpty) {
          try {
            if (profileStorageIdOld != '') {
              await FirebaseStorage.instance
                  .ref()
                  .child(userid)
                  .child(FirebaseCollectionName.profilephoto)
                  .child(profileStorageIdOld!)
                  .delete();
            }
          } catch (_) {
            print('Error occured when deleteing the file from the storage');
          }

          await userprofileinfo.docs.first.reference.update({
            UserProfileKey.bio: bio ?? 'NA',
            UserProfileKey.fileUrl: 'NA',
            UserProfileKey.filename: 'NA',
            UserProfileKey.profileImageStorageId: '',
            UserProfileKey.displayname: name,
          });

          return true;
        }
        final userprofilepayload = UserProfilePayload(
          userId: userid,
          bio: bio ?? 'NA',
          fileUrl: 'NA',
          fileName: 'NA',
          profileImageStorageId: '',
          displayName: name,
        );
        await FirebaseFirestore.instance
            .collection(
              FirebaseCollectionName.usersprofile,
            )
            .add(
              userprofilepayload,
            );
        return true;
      } catch (_) {
        return false;
      } finally {
        isLoading = false;
      }
    }
  }
}
