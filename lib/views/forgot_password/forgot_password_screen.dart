import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/validator/email_validate.dart';
import 'package:instanews_app/views/components/snackbar/error_snackbar.dart';
import 'package:instanews_app/views/components/snackbar/valid_snackbar.dart';
import 'package:instanews_app/views/login_page/login_button.dart';
import 'package:instanews_app/views/login_page/textfield_widget.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final emailcontroller = useTextEditingController();
    final isEnabled = useState(false);
    final isValidEmail = useState(false);
    useEffect(() => () {
      emailcontroller.addListener(
        () {
          if (emailcontroller.text.isEmpty) {
            isEnabled.value = false;
          } else {
            isValidEmail.value = validateEmail(emailcontroller.text);
            isEnabled.value = true;
          }

          if (!isValidEmail.value && isEnabled.value) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                showErrorSnackBar(
                    context: context, message: 'Email is invalid');
              },
            );
          }
        },
      );
    });
    return Scaffold(
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                        ' Forgot Password!',
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text('Please enter your Email below to recover your password',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                        )),
          ),
          LoginTextField(
            hintext: 'Enter your Email',
            iconData: Icons.email,
            controller: emailcontroller,
            type: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 20,
          ),
          LoginButton(onPressed: () async {
            final a = await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text);
            showValidSnackBar(context: context, message: 'we have send you an email to reset the password');
            //Navigator.of(context).pop();
          }, text: 'Recover Password')
        ]),
      ),
    );
  }
}
