import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/constants/firebase_collection_name.dart';
import 'package:instanews_app/state/auth/constants/firebase_field_name.dart';
import 'package:instanews_app/state/comment/extension/comment_sorting_by_request.dart';
import 'package:instanews_app/state/comment/models/comments.dart';
import 'package:instanews_app/state/comment/models/post_with_comment.dart';
import 'package:instanews_app/state/comment/models/posts_comment_request.dart';
import 'package:instanews_app/state/posts/models/post.dart';

final specificPostWithCommentProvider = StreamProvider.family
    .autoDispose<PostWithComments, RequestForPostAndComments>(
  (
    ref,
    RequestForPostAndComments request,
  ) {
    final controller = StreamController<PostWithComments>();

    Post? post;
    Iterable<Comment>? comments;

    void notify() {
      final localPost = post;
      if (localPost == null) {
        return;
      }

      final outputComments = (comments ?? []).applySortingFrom(
        request,
      );

      final result = PostWithComments(
        post: localPost,
        comments: outputComments,
      );

      controller.sink.add(result);
    }

    // watch changes on post

    final postSub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.posts,
        )
        .where(
          FieldPath.documentId,
          isEqualTo: request.postId,
        )
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isEmpty) {
        post = null;
        comments = null;
        notify();
        return;
      }

      final doc = snapshot.docs.first;
      if (doc.metadata.hasPendingWrites) {
        return;
      }
      post = Post(
        postId: doc.id,
        json: doc.data(),
      );
      notify();
    });

    // watch changes to the comment

    final commenQuery = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .where(
          FirebaseFieldName.postId,
          isEqualTo: request.postId,
        )
        .orderBy(
          FirebaseFieldName.createdAt,
          descending: true,
        );

    final limitedCommentsQuery =
        request.limit != null ? commenQuery.limit(request.limit!) : commenQuery;

    final commentSub = limitedCommentsQuery.snapshots().listen(
      (snapshot) {
        comments = snapshot.docs
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => Comment(
                doc.data(),
                id: doc.id,
              ),
            )
            .toList();
        notify();
      },
    );

    ref.onDispose(() {
      postSub.cancel();
      commentSub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
