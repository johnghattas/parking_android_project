import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:parking_project/shared/constant_widget.dart';
import 'package:parking_project/widgets/test.dart';

import '../shared/screen_sized.dart';

class MapHome extends StatefulWidget {
  @override
  _MapHomeState createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  List<Marker> AllMarkers = [];
  double lat = 0.0;
  double long = 0.0;
  Completer<GoogleMapController> _controller = Completer();
  PageController _pageController = PageController(viewportFraction: 0.89);

  bool _minimize = false;

  bool _isUserSwipe = false;

  // 🚨 Json Function That Take Data And Fill up The List Of Markers 🚨
  Future GetData() async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/garages';
    var Response = await http.get(url);
    var ResbonsBody = jsonDecode(Response.body);

    for (int i = 0; i < ResbonsBody['data'].length; i++) {
      AllMarkers.add(
        Marker(
            onTap: () {
              _pageController.animateToPage(i,
                  duration: Duration(milliseconds: 20), curve: Curves.easeIn);
            },
            icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(), 'assets/map/garage3.png'),
            markerId: MarkerId('$i'),
            position: LatLng(double.parse(ResbonsBody['data'][i]['lat']),
                double.parse(ResbonsBody['data'][i]['long']))),
      );
    }
    setState(() {});
    return ResbonsBody;
  }

  @override
  void initState() {
    super.initState();
    GetData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    MediaQuery.of(context).viewInsets.copyWith(bottom: 30);


    return Scaffold(
      appBar: ConstantWidget.appBarWhite,
      // 🚨 Body Of Google Maps Design 🚨
      body: Stack(children: [
        Positioned(
          width: SizeConfig.width,
          bottom: 0,
          child: SizedBox(
            height: SizeConfig.height - getProportionateScreenHeight(40),
            child: GoogleMap(
              onCameraMoveStarted: (){
                print('started success');
              },
              onCameraMove: (c) {
                print('moved success');

                if(_isUserSwipe){
                  _minimize = false;
                  return;
                }
                _minimize = true;
              },
              onCameraIdle: () {
                _minimize = false;
              },
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                  target: LatLng(30.14254528772857, 31.324295242328564),
                  zoom: 11),
              markers: Set.from(AllMarkers),
              onMapCreated: (GoogleMapController controller) {
                if (!_controller.isCompleted) _controller.complete(controller);
              },
            ),
          ),
        ),

        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            height: getProportionateScreenHeight(170.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.02, 0.16),
                end: Alignment(0.0, 1.0),
                colors: [
                  const Color(0xfffffffff),
                  const Color(0xffffffff).withOpacity(0)
                ],
                stops: [0.0, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x00000000).withOpacity(0.06),
                  offset: Offset(0, 2),
                  blurRadius: 50,
                ),
              ],
            ),
            child: Column(
              children: [
                VerticalSpacing(of: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        alignment: Alignment.center,
                        width: getProportionateScreenWidth(233),
                        height: getProportionateScreenWidth(45),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x2f303030),
                              offset: Offset(3, 6),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Parking In....',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xffbdbdbd),
                              fontWeight: FontWeight.w600,
                              height: 1.7,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      onTap: () {
                        showSearch(context: context, delegate: Search());
                      },
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text(''),
                      shape: CircleBorder(
                        side: BorderSide(color: Colors.amber),
                      ),
                      minWidth: 70,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),

        // 🚨 Button For Getting Your Current Location 🚨
        Positioned(
          right: 0,
          bottom: MediaQuery.of(context).size.height * 0.2 + 10,
          child: Container(
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(Icons.my_location),
              onPressed: () async {
                Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                AllMarkers.add(Marker(
                    markerId: MarkerId('first'),
                    position: LatLng(position.latitude, position.longitude)));
                lat = position.latitude;
                long = position.longitude;
                setState(() {});
                GoToYourLocation();
              },
            ),
          ),
        ),

        // 🚨 Scrolling ListView Of Parking Places On Map 🚨
        Positioned(
          bottom: 10,
          width: SizeConfig.width,
          height: SizeConfig.height * 0.2,
          child: ListAnimation(
              minimize: _minimize,
              height: SizeConfig.height * 0.2,
              minHeight: SizeConfig.height * 0.2 / 2,
              // 🚨 Getting Data From Date Base 🚨
              child: FutureBuilder(
                future: GetData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (pageIndex) async {
                          _isUserSwipe = true;
                          AllMarkers.add(Marker(
                              rotation: 300,
                              icon: await BitmapDescriptor.fromAssetImage(
                                  ImageConfiguration.empty,
                                  "assets/map/marker1.png"),
                              markerId: MarkerId('second'),
                              position: LatLng(
                                  double.parse(
                                      snapshot.data['data'][pageIndex]['lat']),
                                  double.parse(snapshot.data['data'][pageIndex]
                                      ['long']))));
                          lat = double.parse(
                              snapshot.data['data'][pageIndex]['lat']);
                          long = double.parse(
                              snapshot.data['data'][pageIndex]['long']);
                          setState(() {});
                          GoToYourLocation();
                          Future.delayed(Duration(seconds: 10)).asStream();

                          if(!_isUserSwipe) {
                            print('this');
                            return;
                          }
                          _isUserSwipe = false;
                        },
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 1.0),
                              child: Container(
                                width: SizeConfig.width * 0.85,
                                child: Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Container(
                                              width: SizeConfig.width * 0.52,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data['data'][i]
                                                        ['name'],
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                  Text(
                                                    snapshot.data['data'][i]
                                                            ['city'] +
                                                        ', ' +
                                                        snapshot.data['data'][i]
                                                            ['street'],
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // 🚨 Share Button 🚨
                                          Align(
                                            alignment: Alignment(0.0, -0.7),
                                            child: FlatButton(
                                              onPressed: null,
                                              child: Icon(
                                                Icons.share_outlined,
                                                color: Colors.green,
                                              ),
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                      color: Colors.grey)),
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 35),
                                        child: Row(
                                          children: [
                                            // 🚨 Directions Button 🚨
                                            FlatButton.icon(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.directions,
                                                color: Colors.white,
                                              ),
                                              label: Text('Direction'),
                                              textColor: Colors.white,
                                              color: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0)),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            // 🚨 Call Button 🚨
                                            FlatButton.icon(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.call,
                                                color: Colors.green,
                                              ),
                                              label: Text('call'),
                                              textColor: Colors.black,
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // 🚨 When User Click On Card 🚨
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return ListView(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  } else
                    return SpinKitPumpingHeart(
                      color: Colors.red,
                      size: 75.0,
                    );
                },
              )),
        ),
      ]),

    );
  }

  // 🚨 Function That Update New Camera Position For Maps 🚨
  Future<void> GoToYourLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, long), zoom: 11)));
  }
}

// 🚨 Class for Search Method 🚨
class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('');
  }
}
