import 'package:flutter/material.dart';
import 'package:instanews_app/views/main_screen/sliver_appbar/first_custom_appbar.dart';
import 'package:instanews_app/views/main_screen/sliver_appbar/second_custom_appbar.dart';
import 'package:instanews_app/views/main_screen/sliver_appbar/third_custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        child: Text('Hello'),
      ),
    );
  }
}


