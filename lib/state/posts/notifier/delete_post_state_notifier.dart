import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/constants/firebase_collection_name.dart';
import 'package:instanews_app/state/auth/constants/firebase_field_name.dart';
import 'package:instanews_app/state/image_uploads/extensions/get_collection_name_from_file_type.dart';
import 'package:instanews_app/state/image_uploads/typedef/isloading.dart';
import 'package:instanews_app/state/posts/models/post.dart';
import 'package:instanews_app/state/posts/typedef/post_id.dart';

class DeletePostStateNotifier extends StateNotifier<IsLoading> {
  DeletePostStateNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> deletePost({
    required Post post,
  }) async {
    isLoading = true;

    try {
      // delete thumbnail
      await FirebaseStorage.instance
          .ref()
          .child(
            post.userId,
          )
          .child(
            FirebaseCollectionName.thumbnails,
          )
          .child(
            post.thumbnailStorageId,
          )
          .delete();

      // delete original image and video
      await FirebaseStorage.instance
          .ref()
          .child(
            post.userId,
          )
          .child(
            post.fileType.collectionName,
          )
          .child(
            post.originalFileStorageId,
          )
          .delete();

      await _deleteAllDocuments(
        inCollection: FirebaseCollectionName.comments,
        postId: post.postId,
      );

      await _deleteAllDocuments(
        inCollection: FirebaseCollectionName.likes,
        postId: post.postId,
      );

      // finally delete the post itself

      final postInCollection = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .where(
            FieldPath.documentId,
            isEqualTo: post.postId,
          )
          .limit(1)
          .get();

      for (final post in postInCollection.docs){
        await post.reference.delete();
      }    
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<void> _deleteAllDocuments({
    required PostId postId,
    required String inCollection,
  }) {
    return FirebaseFirestore.instance.runTransaction(
      maxAttempts: 3,
      timeout: const Duration(seconds: 20),
      (transaction) async {
        final query = await FirebaseFirestore.instance
            .collection(
              inCollection,
            )
            .where(
              FirebaseFieldName.postId,
              isEqualTo: postId,
            )
            .get();
        for (final doc in query.docs) {
          transaction.delete(
            doc.reference,
          );
        }
      },
    );
  }
}
