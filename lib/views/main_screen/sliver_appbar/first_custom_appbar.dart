import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/providers/auth_state_provider.dart';
import 'package:instanews_app/views/components/dialogbox/alert_model_dialog.dart';
import 'package:instanews_app/views/components/dialogbox/logout_dialog.dart';

class FirstCustomAppbar extends ConsumerWidget {
  const FirstCustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      titleSpacing: 30,
      title: const Text(
        'InstaNews',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      elevation: 0.0,
      backgroundColor: Color.fromARGB(255, 69, 150, 249),
      pinned: true,
      actions: [
        IconButton(
            onPressed: () async {
              bool shouldLogOut = await LogoutDialog().present(context).then(
                    (value) => value ?? false,
                  );
              if (shouldLogOut){
                ref.read(authStateProvider.notifier).logOut();
              }    
              
            },
            icon: const FaIcon(FontAwesomeIcons.signOut))
      ],
    );
  }
}
