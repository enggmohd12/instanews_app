
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/constants/firebase_collection_name.dart';
import 'package:instanews_app/state/posts/typedef/search_term.dart';
import 'package:instanews_app/state/user_profile/models/user_profile.dart';
import 'package:rxdart/rxdart.dart';

final userNameBySearchTerm = StreamProvider.family
    .autoDispose<Iterable<UserProfile>, SearchTerm>((ref, SearchTerm search) {
  final controller = BehaviorSubject<Iterable<UserProfile>>();

  final sub = FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.usersprofile,
      )
      .snapshots()
      .listen((snapshot) {
    final userprofile = snapshot.docs
        .map(
          (docs) => UserProfile(
            json: docs.data()
          ),
        )
        .where(
          (post) => post.displayName.toLowerCase().contains(
                search.toLowerCase(),
              ),
        );
        controller.sink.add(userprofile);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
