import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/views/components/animations/globe_animation_text_view.dart';
import 'package:instanews_app/views/main_screen/sliver_appbar/first_custom_appbar.dart';
import 'package:instanews_app/views/main_screen/sliver_appbar/second_custom_appbar.dart';
import 'package:instanews_app/views/main_screen/sliver_appbar/third_custom_appbar.dart';
import 'package:instanews_app/views/main_screen/user_post_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          const FirstCustomAppbar(),
          const SecondCustomAppBar(),
          const ThirdCustomAppBar(),
          
        ];
      },
      body: const Center(
        child: UserPostView(),
      ),
    );
  }
}


