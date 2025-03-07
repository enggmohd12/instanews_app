import 'package:flutter/foundation.dart' show immutable;
import 'package:instanews_app/state/auth/models/auth_result.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final UserId? userId;
  final bool isLoading;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;

  AuthState copyWithIsLoading(bool isLoading) => AuthState(
        result: result,
        isLoading: isLoading,
        userId: userId,
      );


  AuthState copyWith({required bool isLoading,required UserId? userId,required AuthResult? result}) => AuthState(
        result: result,
        isLoading: isLoading,
        userId: userId,
      );    

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
        userId,
      );
}
