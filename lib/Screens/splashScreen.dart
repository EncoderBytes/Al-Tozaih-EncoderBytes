import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'allTabsScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () => Get.offAll(AllTabsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/app_logo.png',
              width: 200,
              height: 200,
            ),
            Container(
              child: Text('Tozaih',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                'FOOD SECURITY AND ANAYLSIS',
                style: TextStyle(fontSize: 10),
              ),
            )
          ],
        )),
      ),
    );
  }
}
