import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/comment/notifier/send_comment_notifier.dart';
import 'package:instanews_app/state/image_uploads/typedef/isloading.dart';

final sendCommentProvider =
    StateNotifierProvider<SendCommentNotifier, IsLoading>(
        (ref) => SendCommentNotifier());
