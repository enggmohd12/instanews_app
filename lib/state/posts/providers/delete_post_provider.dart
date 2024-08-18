import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/image_uploads/typedef/isloading.dart';
import 'package:instanews_app/state/posts/notifier/delete_post_state_notifier.dart';


final deletePostProvider = StateNotifierProvider<DeletePostStateNotifier,IsLoading>(
  (_) {
   return DeletePostStateNotifier();
  },
);