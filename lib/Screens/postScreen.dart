import 'dart:io';

import 'package:donate_meal/Screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class PostFoodScreen extends StatefulWidget {
  @override
  _PostFoodScreenState createState() => _PostFoodScreenState();
}

class _PostFoodScreenState extends State<PostFoodScreen> {
  String usercheck = "Loading";
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future getCurrentUser() async {
    User _user = await FirebaseAuth.instance.currentUser;
    if (_user != null) {
      print("User: ${_user.displayName ?? "None"}");
      setState(() {
        usercheck = _user.displayName;
      });
    } else {
      Get.to(LoginScreen());
    }
    return _user;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    print("User Signed Out");
    Navigator.pop(context);
  }

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  String showAddress = "Address : ";

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print(_currentPosition);
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.subLocality}, ${place.locality}, ${place.country}";

        print(_currentAddress);
        showAddress = 'Address : ${_currentAddress}';
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _getCurrentLocation();
  }

  final _formKey = GlobalKey<FormState>();
  List<String> spinnerItems = [
    'Marraige Hall',
    'Resturent',
    'Home',
  ];
  String _dropDownValuePlace;
  String _dropDownFoodType;
  String defaultName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    child: Text(
                      'Post Meal',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: DropdownButton(
                        elevation: 5,
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        hint: _dropDownValuePlace == null
                            ? Text('Select Place ')
                            : Text(
                                _dropDownValuePlace,
                                style: TextStyle(color: Colors.black),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        items: ['Resturent', 'Marraige hall'].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _dropDownValuePlace = val;
                            },
                          );
                        },
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: _dropDownValuePlace,
                      fillColor: Colors.white,
                      hintText:
                          '${_dropDownValuePlace != null ? _dropDownValuePlace : defaultName} Name',
                      prefixIcon: Icon(Icons.edit_location_outlined),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Name cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Persons",
                      fillColor: Colors.white,
                      hintText: 'Meal for total persons',
                      prefixIcon: Icon(Icons.people_alt_outlined),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "persons cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Location (Optional)",
                      fillColor: Colors.white,
                      hintText: 'Please enter your location',
                      prefixIcon: Icon(Icons.location_on_outlined),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "location cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Moible number",
                      fillColor: Colors.white,
                      hintText: 'Please enter mobile number',
                      prefixIcon: Icon(Icons.phone),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Mobile no cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Description",
                      fillColor: Colors.white,
                      hintText: 'Please enter description',
                      prefixIcon: Icon(Icons.note),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Description cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(showAddress,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: RaisedButton.icon(
                      elevation: 0,
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      label: Text(
                        'Select Image (Optional)',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: Icon(
                        Icons.photo,
                        color: Colors.white,
                      ),
                      textColor: Colors.black,
                      splashColor: Colors.red,
                      color: Colors.blue,
                    ),
                  ),
                  Card(
                    child: (imageFile == null)
                        ? Text("")
                        : Image.file(
                            File(imageFile.path),
                            height: Get.height * 0.3,
                            width: Get.width,
                          ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: Get.width,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Colors.blue,
                      onPressed: () {},
                      child: Text('Upload Post',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PickedFile imageFile;
  Future _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }
}

//  RaisedButton(
//                 child: Text('Logout'),
//                 onPressed: () {
//                   final GoogleSignIn googleSignIn = new GoogleSignIn();
//                   googleSignIn.isSignedIn().then((s) {
//                     signOutGoogle();
//                   });
//                 },
//               ),
