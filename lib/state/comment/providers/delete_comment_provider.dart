import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/comment/notifier/delete_comment_notifier.dart';
import 'package:instanews_app/state/image_uploads/typedef/isloading.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentNotifier, IsLoading>(
        (_) => DeleteCommentNotifier());
