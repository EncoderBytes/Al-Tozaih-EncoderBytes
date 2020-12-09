import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_meal/Constants/kColors.dart';
import 'package:donate_meal/Constants/showSnack.dart';
import 'package:donate_meal/Screens/postScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'loginScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // CollectionReference users = FirebaseFirestore.instance
  //     .collection('Posts')
  //     .where('status', isEqualTo: 'pending');

  Stream stream;

  @override
  void initState() {
    super.initState();

    // stream = users.snapshots();
    stream = FirebaseFirestore.instance
        .collection('Posts')
        .where('status', isEqualTo: 'Pending')
        .snapshots();
  }

  IconData myIcon;
  Color btnColor;
  final List<int> listId = List<int>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: blue,
          title: Text('Home'),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SafeArea(
              child: Stack(
            children: [
              Container(),
              StreamBuilder<QuerySnapshot>(
                stream: stream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  dynamic items = snapshot.data;
                  if (snapshot.hasError) {
                    return Center(child: Text('Somthing went wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot items = snapshot.data.docs[index];

                      return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(children: [
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(items['profilePhoto']),
                                    radius: 20.0,
                                  ),
                                  SizedBox(width: 7.0),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(items['username'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.0)),
                                      SizedBox(height: 2.0),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Text(
                                          "${items['date'].toDate().toString().substring(0, 16)} | ${items['address']} ",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Container(
                                color: Colors.white,
                                width: Get.width * 1,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      children: [
                                        Material(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                          elevation: 2.0,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          type: MaterialType.transparency,
                                          child: (items['image'] == '')
                                              ? null
                                              : Image.network(
                                                  items['image'],
                                                  height: Get.height * 0.35,
                                                  width: Get.width,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20, top: 5),
                                          child: Text(
                                            '${items['place']}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20, top: 5),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              items['desc'],
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 18),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                    'Food for : ${items['persons']} persons'),
                                              ),
                                              Container(
                                                height: 30,
                                                child: RaisedButton.icon(
                                                  icon: Icon(
                                                    Icons.access_time,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  color: yellow,
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            actions: [
                                                              FlatButton(
                                                                child:
                                                                    Text("Yes"),
                                                                onPressed: () {
                                                                  createRecord(
                                                                      items,
                                                                      index);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                              FlatButton(
                                                                child:
                                                                    Text("No"),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              )
                                                            ],
                                                            title: Text(
                                                                "Donate Food"),
                                                            content: Text(
                                                                "If you can pick this food within 1 Hour then press Yes "),
                                                          );
                                                        });
                                                  },
                                                  label: Text(items['status'],
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ));
                    },
                  );
                },
              ),
              Positioned(
                bottom: 15,
                right: 15,
                child: FloatingActionButton(
                  elevation: 5,
                  backgroundColor: Color(0xffFAB500),
                  child: Icon(FontAwesomeIcons.plus),
                  onPressed: () {
                    _showMyDialog();
                  },
                ),
              )
            ],
          )),
        ));
  }

  Color _iconColor = Colors.black;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Donate Food'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to donate food ?'),
                Text('Post your food along with description and  location.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                Navigator.pop(context);
                Get.to(PostFoodScreen());
                setState(() {});
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  loadingStop(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  void createRecord(DocumentSnapshot items, int index) async {
    loadingStop(true);
    final databaseReference = FirebaseFirestore.instance;
    User _user = await FirebaseAuth.instance.currentUser;

    if (_user != null) {
      String uid = _user.uid;
      await databaseReference
          .collection('users_selected')
          .doc(uid)
          .collection('Posts')
          .doc()
          .set({
        'address': items['address'],
        'date': items['date'],
        'desc': items['desc'],
        'foodName': items['food_name'],
        'image': items['image'],
        'location': items['location'],
        'mobile_number': items['mobile_number'],
        'persons': items['persons'],
        'place': items['place'],
        'profilePhoto': items['profilePhoto'],
        'selected_place': items['selected_place'],
        'status': items['status'],
        'userId': items['userId'],
        'username': items['username'],
      }).then((value) {
        String itemId = items.id;
        updateData(itemId);
      });
    } else {
      loadingStop(false);
      Get.to(LoginScreen());
    }
  }

  void updateData(String id) {
    try {
      final databaseReference = FirebaseFirestore.instance;
      databaseReference
          .collection('Posts')
          .doc(id)
          .update({'status': 'Reserved'}).then((value) {
        loadingStop(false);
        KshowSnakbar(
            'Completed', 'Food is Reserved.. please pick it up within 1 hour.');
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
/*

          

*/

/*

 


*/
