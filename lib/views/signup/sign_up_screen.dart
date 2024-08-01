import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/signup/providers/error_provider.dart';
import 'package:instanews_app/state/signup/providers/is_loading_provider.dart';
import 'package:instanews_app/state/signup/providers/signup_state_provider.dart';
import 'package:instanews_app/validator/email_validate.dart';
import 'package:instanews_app/validator/password_validate.dart';
import 'package:instanews_app/views/components/loading_overlay/loading_screen.dart';
import 'package:instanews_app/views/components/snackbar/error_snackbar.dart';
import 'package:instanews_app/views/signup/Social_Signup.dart';
import 'package:instanews_app/views/signup/password_textfield.dart';
import 'package:instanews_app/views/signup/sign_up_button.dart';
import 'package:instanews_app/views/signup/signup_divider.dart';
import 'package:instanews_app/views/signup/textfield_signup.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final displayNameController = useTextEditingController();
    final cfmController = useTextEditingController();
    final isValidEmail = useState(false);
    final isEmailNotEmpty = useState(false);
    final isValidPassword = useState(false);
    final isPasswordNotEmpty = useState(false);
    final isUserNameNotEmpty = useState(false);
    final isCnfmNotEmpty = useState(false);
    final isCnfmMatched = useState(false);
    useEffect(() {
      emailController.addListener(
        () {
          if (emailController.text.isEmpty) {
            isEmailNotEmpty.value = false;
          } else {
            isValidEmail.value = validateEmail(emailController.text);
            isEmailNotEmpty.value = true;
          }

          if (!isValidEmail.value && isEmailNotEmpty.value) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                showErrorSnackBar(
                    context: context, message: 'Email is invalid');
              },
            );
          }
        },
      );
      passwordController.addListener(
        () {
          if (passwordController.text.isEmpty) {
            isPasswordNotEmpty.value = false;
          } else {
            isValidPassword.value = passwordValidator(passwordController.text);
            isPasswordNotEmpty.value = true;
            if (passwordController.text == cfmController.text) {
              isCnfmMatched.value=true;
            }
          }
          if (!isValidPassword.value && isPasswordNotEmpty.value) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                showErrorSnackBar(
                    context: context,
                    message:
                        'Password should contain atleast One Capital letter,One small letter, number and special character');
              },
            );
          }
        },
      );
      cfmController.addListener(() {
        if (cfmController.text.isEmpty) {
          isCnfmNotEmpty.value = false;
        } else {
          if (passwordController.text == cfmController.text) {
            isCnfmNotEmpty.value = true;
            isCnfmMatched.value = true;
          } else {
            isCnfmMatched.value = false;
            isCnfmNotEmpty.value = true;
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                showErrorSnackBar(
                    context: context, message: 'Password is not matched');
              },
            );
          }
        }
      });
      displayNameController.addListener(
        () {
          isUserNameNotEmpty.value = displayNameController.text.isNotEmpty;
        },
      );
      return () {};
    }, [
      emailController,
      passwordController,
      displayNameController,
      cfmController
    ]);
    ref.listen<bool>(
      isLoadingRegProvider,
      (_, isLoading) {
        if (isLoading) {
          LoadingScreen.instance()
              .show(context: context, text: 'Registering user');
        } else {
          LoadingScreen.instance().hide();
        }
      },
    );
    ref.listen<String>(
      errorMsg,
      (_, next) {
        if (next !='') {
        if (next ==
            'User registered successfully. We have send you an email to verify') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Message'),
                content: Text(next),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        emailController.clear();
                        displayNameController.clear();
                        passwordController.clear();
                        cfmController.clear();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'))
                ],
              );
            },
          );
        } else {
          showErrorSnackBar(context: context, message: next);
        }
        }
      },
    );
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.04,
          ),
          if (Platform.isIOS)
            SizedBox(
              height: screenHeight * 0.1,
              child: Stack(
                children: [
                  // Left aligned icon button
                  Positioned(
                    left: 8.0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  // Center aligned text
                  const Positioned.fill(
                    child: Center(
                      child: Text(
                        'SignUp Here!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (Platform.isAndroid)
            SizedBox(
              height: screenHeight * 0.1,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SignUp Here!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          SignUpTextField(
            type: TextInputType.name,
            hintext: 'User Name',
            iconData: Icons.person,
            controller: displayNameController,
          ),
          SignUpTextField(
            type: TextInputType.emailAddress,
            hintext: 'Email Address',
            iconData: Icons.email_outlined,
            controller: emailController,
          ),
          SignUpPasswordTextField(
            type: TextInputType.name,
            hintext: 'Password',
            iconData: Icons.shield_outlined,
            controller: passwordController,
          ),
          SignUpPasswordTextField(
            type: TextInputType.name,
            hintext: 'Confirm Password',
            iconData: Icons.shield_outlined,
            controller: cfmController,
          ),
          SignUpButton(
            onPressed: isValidEmail.value &&
                    isValidPassword.value &&
                    isPasswordNotEmpty.value &&
                    isUserNameNotEmpty.value &&
                    isEmailNotEmpty.value &&
                    isCnfmMatched.value &&
                    isCnfmNotEmpty.value
                ? () {
                    ref
                        .read(signupStateProvider.notifier)
                        .createUserWithEmailPassword(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString(),
                          displayName: displayNameController.text.toString(),
                        );
                        
                  }
                : null,
            text: 'Register',
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          const SignUpDivider(),
          SizedBox(
            height: screenHeight * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialSignUp(
                icon: null,
                imageLink: 'assets/logo/google.png',
                isImage: true,
                onPressed: () {
                  launchUrl(Uri.parse('https://accounts.google.com/signup'));
                },
              ),
              const SizedBox(
                width: 30,
              ),
              SocialSignUp(
                isImage: false,
                onPressed: () {
                  launchUrl(Uri.parse('https://www.facebook.com/signup'));
                },
                icon: FontAwesomeIcons.squareFacebook,
                imageLink: null,
              ),
            ],
          ),
        ],
      )),
    );
  }
}
//  static const facebookSignupUrl = 'https://www.facebook.com/signup';
//   static const google = 'Google';
//   static const googleSignupUrl = 'https://accounts.google.com/signup';