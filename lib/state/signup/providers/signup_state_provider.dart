import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/signup/models/signup_state.dart';
import 'package:instanews_app/state/signup/notifier/signup_notifier.dart';

final signupStateProvider = StateNotifierProvider<SignUpStateNotifier, SignUpState>(
  (ref) => SignUpStateNotifier(),
);
