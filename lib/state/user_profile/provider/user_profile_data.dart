import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/constants/firebase_collection_name.dart';
import 'package:instanews_app/state/auth/providers/user_id_provider.dart';
import 'package:instanews_app/state/user_profile/models/user_profile.dart';
import 'package:instanews_app/state/user_profile/models/user_profile_key.dart';
import 'package:rxdart/rxdart.dart';

final getUserProfileProvider =
    StreamProvider.autoDispose<Iterable<UserProfile>>(
  (ref) {
    final userId = ref.watch(userIdProvider);
    if (userId == null) {
      //print('User ID is null');
      return Stream.value([]);
    }

    //print('Fetching user profile for user ID: $userId');

    final controller = BehaviorSubject<Iterable<UserProfile>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.usersprofile)
        .where(UserProfileKey.userId, isEqualTo: userId)
        .snapshots()
        .listen((snapshot) {
      final documents = snapshot.docs;
      //print('Documents fetched: ${documents.length}');
      
      final userprofile = documents
          .map((doc) {
        //print('Document data: ${doc.data()}');
        return UserProfile(json: doc.data());
      });

      //print('User profiles created: ${userprofile.length}');
      controller.sink.add(userprofile);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
