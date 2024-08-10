import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/providers/auth_state_provider.dart';
import 'package:instanews_app/state/user_profile/provider/image_upload_provider.dart';
import 'package:instanews_app/state/user_profile/provider/user_profile_upload_provider.dart';


final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploadProvider);
  // final deletePost = ref.watch(deletePostProvider);
  // final isSendingComment = ref.watch(sendCommentProvider);
  // final isDeleteComment = ref.watch(deleteCommentProvider);
  final userprofile = ref.watch(userprofileProvider);
  return authState.isLoading || userprofile 
  || isUploadingImage ;
  //|| deletePost || isSendingComment || isDeleteComment;
},);