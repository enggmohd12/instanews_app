import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/constants/firebase_collection_name.dart';
import 'package:instanews_app/state/auth/constants/firebase_field_name.dart';
import 'package:instanews_app/state/likes/models/like.dart';
import 'package:instanews_app/state/likes/models/like_dislike_request.dart';

final doublelikePostProvider =
    FutureProvider.family.autoDispose<bool, LikeDislikeRequest>(
  (ref, LikeDislikeRequest request) async {
    final query = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.likes)
        .where(
          FirebaseFieldName.postId,
          isEqualTo: request.postId,
        )
        .where(
          FirebaseFieldName.userId,
          isEqualTo: request.likedBy,
        )
        .get();

    // to check the user have liked the post or not
    final hasLiked = await query.then(
      (snapshot) => snapshot.docs.isNotEmpty,
    );

    if (hasLiked) {
      // delete the like
      return true;
    } else {
      // create the like
      final like = Like(
        postId: request.postId,
        likeBy: request.likedBy,
        date: DateTime.now(),
      );
      try {
        await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.likes)
            .add(like);
        return true;
      } catch (_) {
        return false;
      }
    }
  },
);
