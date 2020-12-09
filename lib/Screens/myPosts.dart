import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_meal/Constants/kColors.dart';
import 'package:donate_meal/Constants/showSnack.dart';
import 'package:donate_meal/Screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPostsScreen extends StatefulWidget {
  @override
  _MyPostsScreenState createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  Stream stream;
  var _userId;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final List<int> listId = List();

  @override
  void initState() {
    super.initState();
    final User user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      _userId = user.uid;
      print(uid);
      stream = FirebaseFirestore.instance
          .collection('Posts')
          .where('userId', isEqualTo: uid)
          .snapshots();
    } else {
      Get.to(LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        title: Text('My Posts'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: StreamBuilder<QuerySnapshot>(
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
                                                child: items['status'] ==
                                                        'Pending'
                                                    ? RaisedButton.icon(
                                                        icon: Icon(
                                                          Icons.access_time,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        color: yellow,
                                                        onPressed: () {
                                                          try {
                                                            final databaseReference =
                                                                FirebaseFirestore
                                                                    .instance;
                                                            databaseReference
                                                                .collection(
                                                                    'Posts')
                                                                .doc(items.id)
                                                                .update({
                                                              'status':
                                                                  'Reserved'
                                                            }).then((value) {
                                                              KshowSnakbar(
                                                                  'Donation complete',
                                                                  'Thanks for donating and securing the food..');
                                                            });
                                                          } catch (e) {
                                                            print(e.toString());
                                                          }
                                                        },
                                                        label: Text(
                                                            items['status'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      )
                                                    : RaisedButton.icon(
                                                        icon: Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        color: Colors.green,
                                                        onPressed: () {},
                                                        label: Text(
                                                            items['status'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
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
            )
          ],
        ),
      ),
    );
  }
}
