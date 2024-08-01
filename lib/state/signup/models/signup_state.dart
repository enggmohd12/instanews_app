import 'package:flutter/foundation.dart' show immutable;
import 'package:instanews_app/state/signup/models/signup_result.dart';

@immutable
class SignUpState {
  final bool isLoading;
  final SignUpResult? result;
  final String errorMessage;

  const SignUpState({
    required this.errorMessage,
    required this.isLoading,
    required this.result,
  });

  const SignUpState.unknown()
      : result = null,
        isLoading = false,
        errorMessage = "";

  SignUpState copiedWithIsLoading(bool isLoading) => SignUpState(
        errorMessage: errorMessage,
        isLoading: isLoading,
        result: result,
      );

  SignUpState copyWith({required bool isLoading,required String errorMessage,required SignUpResult? result}) => SignUpState(
        result: result,
        isLoading: isLoading,
        errorMessage: errorMessage,
      );    

  SignUpState copiedWithErrorMessage(String errorMessage) => SignUpState(
        errorMessage: errorMessage,
        isLoading: isLoading,
        result: result,
      );    

  @override
  bool operator ==(covariant SignUpState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          errorMessage == other.errorMessage);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
        errorMessage,
      );
}
