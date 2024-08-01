import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/signup/providers/signup_state_provider.dart';

final errorMsg = Provider<String>(
  (ref) => ref.watch(signupStateProvider).errorMessage,
);
