import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instanews_app/views/search_view/search_user.dart';
import 'package:instanews_app/views/search_view/search_view.dart';

class SearchMainScreen extends StatelessWidget {
  const SearchMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(icon: Icon(Icons.feed)),
                Tab(
                  icon: Icon(Icons.person_pin_circle),
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              SearchView(),
              SearchUserView(),
            ],
          )),
    );
  }
}
