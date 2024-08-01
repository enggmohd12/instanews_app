import 'package:firebase_auth/firebase_auth.dart';
import 'package:instanews_app/exceptions/firebase_exception.dart';
import 'package:instanews_app/state/signup/models/signup_result.dart';

class SignUp {
  const SignUp();

Future<SignUpResult> createUser(
      {required String email,
      required String password,
      required String username}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        await currentUser.updateDisplayName(username);
        await currentUser.sendEmailVerification();
        await FirebaseAuth.instance.signOut();
        return SignUpResult.success;
        // return const SignUpState(
        //   result: SignUpResult.success,
        //   isLoading: false,
        //   errorMessage:
        //       'User registered successfully. We have send you an email to verify',
        // );
      } else {
        return SignUpResult.failure;
        // return const SignUpState(
        //     result: SignUpResult.failure,
        //     isLoading: false,
        //     errorMessage: 'Some error occured when registering',);
      }
    } on FirebaseAuthException catch (e) {

      //throw FirebaseAuthException;
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw TooManyRequestAuthException();
      }
    } catch (_) {
      throw Exception('Some error occured');
      // return const SignUpState(
      //     result: SignUpResult.failure,
      //     isLoading: false,
      //     errorMessage: 'Some error occured when registering');
    }
  }

}
