import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/constants/firebase_collection_name.dart';
import 'package:instanews_app/state/auth/constants/firebase_field_name.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';
import 'package:instanews_app/state/user_profile/models/user_profile.dart';

final userprofilePostProvider =
    StreamProvider.family.autoDispose<Iterable<UserProfile>, UserId>(
  (ref, UserId userId) {
    final controller = StreamController<Iterable<UserProfile>>();

    final sub = FirebaseFirestore.instance.collection(
      FirebaseCollectionName.usersprofile,
    )
    .where(FirebaseFieldName.userId,isEqualTo: userId)
    .snapshots()
    .listen((snapshot) {
      final documents = snapshot.docs;

      final userprofile = documents.map((data) {
        return UserProfile(json: data.data());
      },);

      controller.sink.add(userprofile);
     })
    ;

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
