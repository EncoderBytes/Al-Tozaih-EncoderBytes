import 'package:donate_meal/Screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostFoodScreen extends StatefulWidget {
  @override
  _PostFoodScreenState createState() => _PostFoodScreenState();
}

class _PostFoodScreenState extends State<PostFoodScreen> {
  String usercheck = "Loading";

  Future getCurrentUser() async {
    User _user = await FirebaseAuth.instance.currentUser;
    if (_user != null) {
      print("User: ${_user.displayName ?? "None"}");
    } else {
      Get.to(LoginScreen());
    }
    return _user;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(usercheck),
        ),
      ),
    );
  }
}
