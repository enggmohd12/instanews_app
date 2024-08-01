import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/views/main_screen/list_pages.dart';
//import 'package:instanews_app/views/main_screen/sliver_appbar/first_custom_appbar.dart';
//import 'package:instanews_app/views/main_screen/sliver_appbar/second_custom_appbar.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',


          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
        ],
        currentIndex: _selectedIndex, //New
  onTap: _onItemTapped,     
      ),
    )
        // body: NestedScrollView(
        //   headerSliverBuilder: (context, innerBoxIsScrolled) {
        //       return <Widget>[
        //         const FirstCustomAppbar(),
        //         const SecondCustomAppBar(),
        //       ];
        //   },
        //   body: const Center(
        //     child: Text('Hello'),
        //   ),
        // )
        ;
  }
  void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}
}
