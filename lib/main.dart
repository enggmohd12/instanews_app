import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/providers/auth_state_provider.dart';
import 'package:instanews_app/state/auth/providers/invalid_login.dart';
import 'package:instanews_app/state/auth/providers/is_email_not_verified.dart';
import 'package:instanews_app/state/auth/providers/is_logged_in_provider.dart';
import 'package:instanews_app/state/providers/is_loading_provider.dart';
import 'package:instanews_app/views/components/loading_overlay/loading_screen.dart';
import 'package:instanews_app/views/components/snackbar/error_snackbar.dart';
import 'package:instanews_app/views/login_page/login_page.dart';
import 'package:instanews_app/views/main_screen/main_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          ref.listen<bool>(isLoadingProvider, (_, isLoading) {
            if (isLoading){
              LoadingScreen.instance().show(context: context);
            } else{
              LoadingScreen.instance().hide();
            }
           });

           ref.listen<bool>(isEmailNotVerified, (_, isNotVerified) { 
            if (isNotVerified){
              showErrorSnackBar(context: context, message: 'Email is not verified. Please verify your email');
            }
           });

           ref.listen<bool>(invalidLoginProvider, (_, invalid) { 
            if (invalid){
              showErrorSnackBar(context: context, message: 'The username and password entered is incorrect');
            }
           });
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const MainScreen();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main View'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return TextButton(
            onPressed: () async{
              await ref.read(authStateProvider.notifier).logOut();
            },
            child: const Text('Log Out'),
          );
        },
      ),
    );
  }
}
