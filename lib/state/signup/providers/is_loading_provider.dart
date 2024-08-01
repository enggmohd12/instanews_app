import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/signup/providers/signup_state_provider.dart';

final isLoadingRegProvider = Provider<bool>(
  (ref) => ref.watch(signupStateProvider).isLoading,
);
