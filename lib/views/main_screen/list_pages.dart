import 'package:flutter/material.dart';
import 'package:instanews_app/views/explore/explore_view.dart';
import 'package:instanews_app/views/main_screen/sliver_appbar/home_screen.dart';
import 'package:instanews_app/views/search_view/search_main_screen.dart';

const List<Widget> pages = <Widget>[
  HomeScreen(),
  SearchMainScreen(),
  ExploreView(),
];