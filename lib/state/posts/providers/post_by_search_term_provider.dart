import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/constants/firebase_collection_name.dart';
import 'package:instanews_app/state/auth/constants/firebase_field_name.dart';
import 'package:instanews_app/state/posts/models/post.dart';
import 'package:instanews_app/state/posts/typedef/search_term.dart';

final postsBySearchTerm = StreamProvider.family
    .autoDispose<Iterable<Post>, SearchTerm>((ref, SearchTerm search) {
  final controller = StreamController<Iterable<Post>>();

  final sub = FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.posts,
      )
      .orderBy(FirebaseFieldName.createdAt, descending: true)
      .snapshots()
      .listen((snapshot) {
    final post = snapshot.docs
        .map(
          (docs) => Post(
            postId: docs.id,
            json: docs.data(),
          ),
        )
        .where(
          (post) => post.message.toLowerCase().contains(
                search.toLowerCase(),
              ),
        );
        controller.sink.add(post);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
