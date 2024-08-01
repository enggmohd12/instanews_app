import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/user_profile/notifier/user_profile_notifier.dart';
import 'package:instanews_app/state/user_profile/typedef/isloading.dart';

final userprofileProvider =
    StateNotifierProvider<UserProfileNotifier, IsLoading>(
  (ref) => UserProfileNotifier(),
);
