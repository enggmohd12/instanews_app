import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/exceptions/firebase_exception.dart';
import 'package:instanews_app/state/signup/backend/signup.dart';
import 'package:instanews_app/state/signup/models/signup_result.dart';
import 'package:instanews_app/state/signup/models/signup_state.dart';

class SignUpStateNotifier extends StateNotifier<SignUpState> {
  final _register = const SignUp();

  SignUpStateNotifier() : super(const SignUpState.unknown());

  Future<void> createUserWithEmailPassword(
      {required String email,
      required String password,
      required String displayName}) async {
    try {
      state = state.copyWith(
        isLoading: true,
        errorMessage: '',
        result: null,
      );
      final value = await _register.createUser(
          email: email, password: password, username: displayName);
      if (value == SignUpResult.success) {
        // state = SignUpState(
        //   errorMessage:
        //       'User registered successfully. We have send you an email to verify',
        //   isLoading: false,
        //   result: value,
        // );
        state = state.copyWith(
          isLoading: false,
          errorMessage:
              'User registered successfully. We have send you an email to verify',
          result: value,
        );
      } else {
        // state = SignUpState(
        //   errorMessage: "Some error occured",
        //   isLoading: false,
        //   result: value,
        // );
        state = state.copyWith(
          isLoading: false,
          errorMessage:
              'Some error occured',
          result: value,
        );
      }
    } on InvalidEmailAuthException catch (_) {
      // state = state.copiedWithIsLoading(false);
      // state = state.copiedWithErrorMessage('Invalid Email');
      state = state.copyWith(
          isLoading: false,
          errorMessage:
              'Invalid Email',
          result: null,
        );
    } on WeakPasswordAuthException catch (_) {
      // state = state.copiedWithIsLoading(false);
      // state = state.copiedWithErrorMessage('Weak password');
      state = state.copyWith(
          isLoading: false,
          errorMessage:
              'Weak password',
          result: null,
        );
    } on EmailAlreadyInUseAuthException catch (_) {
      // state = state.copiedWithIsLoading(false);
      // state = state.copiedWithErrorMessage('Email is already registered');
      state = state.copyWith(
          isLoading: false,
          errorMessage:
              'Email is already registered',
          result: null,
        );
    } on TooManyRequestAuthException catch (_) {
      // state = state.copiedWithIsLoading(false);
      // state = state.copiedWithErrorMessage('Too many request to the server');
      state = state.copyWith(
          isLoading: false,
          errorMessage:
              'Too many request to the server',
          result: null,
        );
    }
    //  on FirebaseAuthException catch (e) {
    //   state = state.copiedWithIsLoading(false);
    //   if (e.code == 'weak-password') {
    //     state = state.copiedWithErrorMessage('Weak password');
    //   } else if (e.code == 'email-already-in-use') {
    //     state = state.copiedWithErrorMessage('Email already in use');
    //   } else if (e.code == 'invalid-email') {
    //     state = state.copiedWithErrorMessage('Invalid Email');
    //   } else {
    //     state = state.copiedWithErrorMessage('Some error occured when registering');
    //   }
    // }
    catch (m) {
      state = state.copiedWithIsLoading(false);
      state = state.copiedWithErrorMessage('Some error occured');
      state = state.copyWith(
          isLoading: false,
          errorMessage:
              'Some error occured',
          result: null,
        );
    }
  }
}
