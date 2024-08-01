import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/models/auth_result.dart';
import 'package:instanews_app/state/auth/providers/auth_state_provider.dart';

final invalidLoginProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.failure;
},);