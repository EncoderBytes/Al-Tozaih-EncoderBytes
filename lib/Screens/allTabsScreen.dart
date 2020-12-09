import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donate_meal/Constants/kColors.dart';
import 'package:donate_meal/Screens/homeScreen.dart';
import 'package:donate_meal/Screens/myPosts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ReservedFoodScreen.dart';

class AllTabsScreen extends StatefulWidget {
  @override
  _AllTabsScreenState createState() => _AllTabsScreenState();
}

class _AllTabsScreenState extends State<AllTabsScreen> {
  var _currentIndex = 1;

  List<Widget> _childrenMain = [
    ReservedFoodScreen(),
    HomeScreen(),
    MyPostsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: _childrenMain[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: blue,
        height: Get.height * 0.08,
        animationDuration: Duration(
          milliseconds: 500,
        ),
        index: _currentIndex,
        animationCurve: Curves.easeIn,
        items: <Widget>[
          Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.list,
            color: Colors.white,
          )
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
