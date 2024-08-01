import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/providers/auth_state_provider.dart';
import 'package:instanews_app/validator/email_validate.dart';
import 'package:instanews_app/views/components/snackbar/error_snackbar.dart';
import 'package:instanews_app/views/login_page/forgot_password_link_button.dart';
import 'package:instanews_app/views/login_page/login_button.dart';
import 'package:instanews_app/views/login_page/login_divider.dart';
import 'package:instanews_app/views/login_page/password_textfield_login_screen.dart';
import 'package:instanews_app/views/login_page/signup_link.dart';
import 'package:instanews_app/views/login_page/social_login.dart';
import 'package:instanews_app/views/login_page/textfield_widget.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isValidEmail = useState(false);
    final isEmailNotEmpty = useState(false);
    final isPasswordNotEmpty = useState(false);

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
            isPasswordNotEmpty.value = true;
          }
        },
      );

      return () {};
    }, [
      emailController,
      passwordController,
    ]);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.08,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.07,
            ),
            LoginTextField(
              type: TextInputType.emailAddress,
              hintext: 'Email Address',
              iconData: Icons.email_outlined,
              controller: emailController,
            ),
            LoginPasswordTextField(
              type: TextInputType.name,
              hintext: 'Password',
              iconData: Icons.shield_outlined,
              controller: passwordController,
            ),
            ForgotLinkButton(
              onPressed: () {},
              text: 'Forgot Password?',
            ),
//Color.fromARGB(255, 68, 118, 255)
            LoginButton(
                onPressed: isEmailNotEmpty.value &&
                        isPasswordNotEmpty.value &&
                        isValidEmail.value
                    ? () {
                        ref.read(authStateProvider.notifier).loginWithEmail(
                              emailController.text.toString(),
                              passwordController.text.toString(),
                            );
                      }
                    : null,
                text: 'Login'),
            SizedBox(
              height: screenHeight * 0.04,
            ),

            const LoginDivider(),

            SizedBox(
              height: screenHeight * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialLogin(
                  icon: null,
                  imageLink: 'assets/logo/google.png',
                  isImage: true,
                  onPressed: () {
                    ref.read(authStateProvider.notifier).loginWithGoogle();
                  },
                ),
                const SizedBox(
                  width: 30,
                ),
                SocialLogin(
                  isImage: false,
                  onPressed: () {
                    ref.read(authStateProvider.notifier).loginWithFacebook();
                  },
                  icon: FontAwesomeIcons.squareFacebook,
                  imageLink: null,
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            const SignUpLink(),
          ],
        ),
      ),
    );
  }
}
