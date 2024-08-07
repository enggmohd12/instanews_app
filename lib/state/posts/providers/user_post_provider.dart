import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/constants/firebase_collection_name.dart';
import 'package:instanews_app/state/auth/constants/firebase_field_name.dart';
import 'package:instanews_app/state/auth/providers/user_id_provider.dart';
import 'package:instanews_app/state/posts/models/post.dart';

final userPostProvider = StreamProvider.autoDispose<Iterable<Post>>((ref) {
  final controller = StreamController<Iterable<Post>>();
  final userId = ref.watch(userIdProvider);
  controller.onListen = () {
    controller.sink.add([]);
  };

  final sub = FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.posts,
      )
      .orderBy(
        FirebaseFieldName.createdAt,
        descending: true,
      )
      .where(
        FirebaseFieldName.userId,
        isEqualTo: userId,
      )
      .snapshots()
      .listen((snapshot) {
    final documents = snapshot.docs;
    final posts = documents
        .where(
          (doc) => !doc.metadata.hasPendingWrites,
        )
        .map(
          (doc) => Post(
            postId: doc.id,
            json: doc.data(),
          ),
        );
      controller.sink.add(posts);  
  });

  ref.onDispose(() { 
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
