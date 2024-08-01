import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/backend/authenticator.dart';
import 'package:instanews_app/state/auth/models/auth_result.dart';
import 'package:instanews_app/state/auth/models/auth_state.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';
import 'package:instanews_app/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copyWithIsLoading(true);

    await _authenticator.logout();

    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
      await saveProfileInfo(userId: userId);
      state = AuthState(
        result: result,
        isLoading: false,
        userId: userId,
      );
    } else if (result == AuthResult.failure) {
      state = AuthState(
        result: result,
        isLoading: false,
        userId: null,
      );
    } else {
      state = AuthState(
        result: result,
        isLoading: false,
        userId: null,
      );
    }
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
      await saveProfileInfo(userId: userId);
      state = AuthState(
        result: result,
        isLoading: false,
        userId: userId,
      );
    } else if (result == AuthResult.failure) {
      state = AuthState(
        result: result,
        isLoading: false,
        userId: null,
      );
    } else {
      state = AuthState(
        result: result,
        isLoading: false,
        userId: null,
      );
    }
  }

  Future<void> loginWithEmail(String email, String password) async {
    state = state.copyWith(
      isLoading: true,
      result: null,
      userId: null,
    );
    final result = await _authenticator.loginWithEmail(email, password);
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
      await saveProfileInfo(userId: userId);
      // state = AuthState(
      //   result: result,
      //   isLoading: false,
      //   userId: userId,
      // );
      state = state.copyWith(
        isLoading: false,
        result: result,
        userId: userId,
      );
    } else if (result == AuthResult.notVerified) {
      // state = AuthState(
      //   result: result,
      //   isLoading: false,
      //   userId: null,
      // );
      state = state.copyWith(
        isLoading: false,
        result: result,
        userId: null,
      );
    } else if (result == AuthResult.aborted) {
      // state = AuthState(
      //   result: result,
      //   isLoading: false,
      //   userId: null,
      // );
      state = state.copyWith(
        isLoading: false,
        result: result,
        userId: null,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        result: result,
        userId: null,
      );
    }
  }

  Future<void> saveUserInfo({required UserId userId}) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.getDisplayName,
        email: _authenticator.email,
      );

  Future<void> saveProfileInfo({required UserId userId}) =>
      _userInfoStorage.saveUserProfile(
        userId: userId,
        displayName: _authenticator.getDisplayName,
      );
}
