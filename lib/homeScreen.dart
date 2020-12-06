import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'models/post.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Post> myPost = posts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  itemCount: myPost.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(children: [
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage(myPost[index].profileImage),
                              radius: 20.0,
                            ),
                            SizedBox(width: 7.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(myPost[index].resturentName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0)),
                                SizedBox(height: 2.0),
                                Text(
                                  myPost[index].time,
                                  style: TextStyle(fontSize: 13),
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
                          height: Get.height * 0.51,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              children: [
                                Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  elevation: 2.0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  type: MaterialType.transparency,
                                  child: Image.asset(
                                    myPost[index].mealImage,
                                    height: Get.height * 0.35,
                                    width: Get.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                          alignment: Alignment.topLeft,
                                          child: RatingBar.builder(
                                            itemSize: 15,
                                            initialRating: myPost[index].rating,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 0.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          )),
                                      Spacer(),
                                      RichText(
                                          text: TextSpan(
                                              text: ' Meals for: ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12,
                                              ),
                                              children: [
                                            TextSpan(
                                                text: myPost[index].persons,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: ' persons',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          ]))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 25,
                                        child: RaisedButton(
                                          onPressed: () {},
                                          child: Text('Reserve'),
                                        ),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.clock,
                                        color: Colors.amber,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 15,
                right: 15,
                child: FloatingActionButton(
                  backgroundColor: Colors.green[900],
                  child: Icon(FontAwesomeIcons.plus),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ));
  }
}
