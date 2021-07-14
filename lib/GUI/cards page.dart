import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:parking_project/GUI/Edit.dart';
import 'package:parking_project/models/comments.dart';

// import 'package:garage/Gui/floors_model.dart';
import 'package:parking_project/fetch.dart';
import 'package:parking_project/models/garage_model.dart';

class FilledData extends StatefulWidget {
  @override
  _FilledDataState createState() => _FilledDataState();
}

String _token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2MjU3OTM2NzgsImV4cCI6MTYyNzI2MjQ3OCwibmJmIjoxNjI1NzkzNjc4LCJqdGkiOiJmZjgzSWtZMWxrRE1PcE01Iiwic3ViIjoiNDJhS1V5YVdMRFZPamZGTzh3T0dET3hBTXZiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.Ux-3se9XtYte0f8lxo-EyCQFG5BB360ufk3FLLWYY_Y';

class _FilledDataState extends State<FilledData> {
  FetchApi fetchApi = FetchApi();

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    // var _width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: fetchApi.getData(_token),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        if (snapshot.hasData) {
          List<Model> garage = snapshot.data;
          // List<FloorsModel> floorsModel = snapshot.data;
          // List<Model> garages=snapshot.data;
          return Column(
            children: List.generate(
                garage.length,
                (index) => Center(
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 10.0),
                            // height: _height / 1.6,
                            // width: _width,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Edit(

                                              garage: garage[index],
                                            )));
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  shadowColor: Colors.blue.shade100,
                                  margin: EdgeInsets.all(3.0),
                                  elevation: 7.0,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 60.0,
                                              width: double.infinity,
                                              child: Card(
                                                elevation: 4.0,
                                                // shadowColor:Colors.teal ,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.local_parking,
                                                      color: Colors.deepOrange,
                                                    ),
                                                    VerticalDivider(
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                      'Parking name  ',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .teal.shade600,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                        '${garage[index].name}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .brown.shade300,
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                                margin: EdgeInsets.all(8.0),
                                                // elevation: 15.0,/*shadowColor: Colors.teal*/
                                              ),
                                            ),
                                            Container(
                                              height: 60.0,
                                              width: double.infinity,
                                              child: Card(
                                                elevation: 4.0,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.home_work_outlined,
                                                      color: Colors.deepOrange,
                                                    ),
                                                    VerticalDivider(
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                      'Address  ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .teal.shade500,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      child: RichText(
                                                          overflow:
                                                              TextOverflow.clip,
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .brown
                                                                    .shade300,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            text:
                                                                '${garage[index].bNumber},'
                                                                '${garage[index].street},st.'
                                                                '${garage[index].city},',
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                margin: EdgeInsets.all(8.0),
                                                // elevation: 8.0,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 60.0,
                                                    width: 180.0,
                                                    child: Card(
                                                      elevation: 4.0,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .people_alt_outlined,
                                                            color: Colors
                                                                .deepOrange,
                                                          ),
                                                          VerticalDivider(
                                                              color:
                                                                  Colors.grey),
                                                          Text(
                                                            'number',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .teal
                                                                    .shade500,
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            '${garage[index].floor}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .brown
                                                                    .shade300),
                                                          )
                                                        ],
                                                      ),
                                                      margin:
                                                          EdgeInsets.all(8.0),
                                                      // elevation: 8.0,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 60.0,
                                                    width: 180.0,
                                                    child: Card(
                                                      elevation: 4.0,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .people_alt_outlined,
                                                            color: Colors
                                                                .deepOrange,
                                                          ),
                                                          VerticalDivider(
                                                              color:
                                                                  Colors.grey),
                                                          Text(
                                                            'Capacity  ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .teal
                                                                    .shade500,
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            '${garage[index].floor}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .brown
                                                                    .shade300),
                                                          )
                                                        ],
                                                      ),
                                                      margin:
                                                          EdgeInsets.all(8.0),
                                                      // elevation: 8.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Padding(padding: EdgeInsets.only(right: 8.0)),

                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0, top: 8.0),
                                                  child: SizedBox(
                                                      width: 80,
                                                      height: 80,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            new AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.brown
                                                                    .shade200),
                                                        value: (garage[index]
                                                                    .numFreeLots ??
                                                                50) /
                                                            (garage[index]
                                                                    .capacity ??
                                                                100),
                                                        backgroundColor: Colors
                                                            .teal.shade500,
                                                        strokeWidth: 10.0,
                                                      )),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        padding: EdgeInsets.all(8.0),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 40.0, top: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            //filled
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Container(
                                                height: 50.0,
                                                width: 120.0,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Available',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .teal.shade500,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        '${(garage[index].numFreeLots ?? 50) / (garage[index].capacity ?? 100) * 100}%',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .teal.shade500,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            //free
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Container(
                                                height: 50.0,
                                                width: 120.0,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Busy',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .brown.shade300,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '${(garage[index].numFreeLots ?? 50) / (garage[index].capacity ?? 100) * 100}%',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .brown.shade300,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                            shape: StadiumBorder(),
                                            elevation: 5.0,
                                            shadowColor: Colors.grey,
                                          ),
                                          onPressed: () => showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(40),
                                                ),
                                              ),
                                              barrierColor:
                                                  Colors.black.withOpacity(0.5),
                                              builder: (context) {
                                                return Container(height: _height*0.65,
                                                  child: FutureBuilder(
                                                      future:
                                                          fetchApi.getComments(
                                                              garage[index].id!,
                                                              _token),
                                                      builder:
                                                          (BuildContext context,
                                                              AsyncSnapshot
                                                                  asyncSnapshot) {
                                                        if (asyncSnapshot.hasError) {
                                                          if(asyncSnapshot.error is SocketException){
                                                            return Container(child: Column(
                                                              children: [
                                                                Image.asset('assets/no_internet.jpg')

                                                              ],
                                                            ),);
                                                          }
                                                          print(asyncSnapshot.error);
                                                        }


                                                        if (asyncSnapshot.hasData) {
                                                          List<Comments> comment =
                                                              asyncSnapshot.data;
                                                          if(comment.length==0){
                                                            return Center(
                                                              child: Container(child:
                                                                Text("No comments on this Garage..",
                                                                style: TextStyle(color: Colors.grey.shade700,fontSize: 20),),),
                                                            );
                                                          }
                                                          return Container(child: Column(
                                                            children: [
                                                              Padding(
                                                                  padding:
                                                                  EdgeInsets.only(top: 10.0)),
                                                              Container(
                                                                  width:
                                                                  220,
                                                                  height:
                                                                  2.0,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.grey,
                                                                      boxShadow: [])),
                                                              Padding(
                                                                  padding:
                                                                  EdgeInsets.only(top: 10.0)),
                                                              Text(
                                                                'Comments',
                                                                style: TextStyle(
                                                                    letterSpacing:
                                                                    1,
                                                                    color: Colors
                                                                        .grey.shade700,
                                                                    fontWeight: FontWeight
                                                                        .bold,
                                                                    height:
                                                                    1.2,
                                                                    fontSize:
                                                                    15.0),
                                                              ),
                                                            Expanded(
                                                              child: Container(height: _height*0.65,child:
                                                              ListView.builder(
                                                                  itemCount: comment.length,
                                                                  itemBuilder: (context, index) => Container(
                                                                    // height: _height * 0.65,
                                                                      child: Column(children: [
                                                                        Padding(
                                                                            padding:
                                                                            EdgeInsets.only(top: 20.0)),
                                                                        Padding(
                                                                          padding:
                                                                          const EdgeInsets.only(top: 25.0),
                                                                          child:
                                                                          ListTile(
                                                                            leading:
                                                                            CircleAvatar(
                                                                              child:
                                                                              ClipRRect(
                                                                                borderRadius: BorderRadius.circular(20.0),
                                                                                child: Icon(
                                                                                  Icons.person,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              backgroundColor:
                                                                              Colors.teal,
                                                                            ),
                                                                            trailing:
                                                                            Column(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.favorite,
                                                                                  color: Colors.orange,
                                                                                ),
                                                                                Text('10'),
                                                                              ],
                                                                            ),
                                                                            title:
                                                                            Wrap(
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Text("${comment[index].firstName } ${comment[index].secondName??""}",
                                                                                        style: TextStyle(letterSpacing: 0.8, fontWeight: FontWeight.bold, fontSize: 14)),
                                                                                    RatingBar.builder(updateOnDrag: false,
                                                                                      initialRating: 3,
                                                                                      itemSize: 20.0,
                                                                                      minRating: 1,
                                                                                      tapOnlyMode: false,
                                                                                      ignoreGestures: true,
                                                                                      unratedColor: Colors.grey.shade400,
                                                                                      direction: Axis.horizontal,
                                                                                      allowHalfRating: true,
                                                                                      itemCount: 5,
                                                                                      itemPadding: EdgeInsets.symmetric(horizontal: 0),
                                                                                      itemBuilder: (context, _) => Icon(
                                                                                        Icons.star,
                                                                                        color: Colors.orange,
                                                                                      ),
                                                                                      onRatingUpdate: (rating) {
                                                                                        print(rating);
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            subtitle:
                                                                            Text(
                                                                              '${comment[index].comment}',
                                                                              maxLines: 5,
                                                                              style: TextStyle(height: 1.5, wordSpacing: 1),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ])))),
                                                            )],
                                                          ),);
                                                        }
                                                        return Center(child: RefreshProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.teal ),));
                                                      }),
                                                );
                                              }),
                                          // shape:RoundedRectangleBorder(
                                          //             borderRadius: BorderRadius.circular(15.0)
                                          //   ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'View user comments and reviews....  ',
                                                style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2.0),
                            height: 45.0,
                            width: 45.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepOrange),
                            child: Center(
                                child: FittedBox(
                                    child: Column(
                              children: [
                                Text("${garage[index].price}"),
                                Text(
                                  "LE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                )
                              ],
                            ))),
                          ),
                        ],
                      ),
                    )),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
// void _modalBottomSheetMenu(){
//   showModalBottomSheet(
//       context: context,
//       builder: (builder){
//         return new Container(
//           height: 350.0,
//           color: Colors.transparent, //could change this to Color(0xFF737373),
//           //so you don't have to change MaterialApp canvasColor
//           child: new Container(
//               decoration: new BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: new BorderRadius.only(
//                       topLeft: const Radius.circular(10.0),
//                       topRight: const Radius.circular(10.0))),
//               child: new Center(
//                 child: new Text("This is a modal sheet"),
//               )),
//         );
//       }
//   );
// }

}
