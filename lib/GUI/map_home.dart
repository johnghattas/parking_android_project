import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_project/block/garage_bloc.dart';
import 'package:parking_project/models/garage.dart';
import 'package:parking_project/shared/constant_widget.dart';
import 'package:parking_project/widgets/card_garage_item.dart';
import 'package:parking_project/widgets/test.dart';

import '../shared/screen_sized.dart';

class MapHome extends StatefulWidget {
  @override
  _MapHomeState createState() => _MapHomeState();
}

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

// 🚨 Class for Search Method 🚨
class _MapHomeState extends State<MapHome> with WidgetsBindingObserver {
  List<Marker> allMarkers = [];
  double lat = 0.0;
  double long = 0.0;
  Completer<GoogleMapController> _controller = Completer();
  PageController _pageController = PageController(viewportFraction: 0.89);

  bool _minimize = false;

  bool _isUserSwipe = false;

  List<Garage>? garages = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    MediaQuery.of(context).viewInsets.copyWith(bottom: 30);
    print('Build');

    return Scaffold(
      appBar: ConstantWidget.appBarWhite as PreferredSizeWidget?,
      // 🚨 Body Of Google Maps Design 🚨
      body: Stack(children: [
        BlocConsumer<GarageBloc, GarageState>(
          listener: (context, state) {},
          buildWhen: (previous, current) {
            if (current is LoadedDataState) {
              return true;
            }
            return false;
          },
          builder: (context, state) => Positioned(
            width: SizeConfig.width,
            bottom: 0,
            child: SizedBox(
              height: SizeConfig.height! - getProportionateScreenHeight(40),
              child: GoogleMap(
                mapType: MapType.normal,
                onCameraMoveStarted: () {
                  print('started success');
                },
                onCameraMove: (c) {
                  print('moved success');

                  if (_isUserSwipe) {
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
                markers: Set.from(allMarkers),
                onMapCreated: (GoogleMapController controller) {
                  // if (!_controller.isCompleted)
                  _controller.complete(controller);
                },
              ),
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
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          right: 0,
          bottom: context.watch<GarageBloc>().bottomPosition +
              SizeConfig.height! * 0.2 +
              20,
          child: Container(
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(Icons.my_location),
              onPressed: () async {
                Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                allMarkers.add(Marker(
                    markerId: MarkerId('first'),
                    position: LatLng(position.latitude, position.longitude)));
                lat = position.latitude;
                long = position.longitude;
                setState(() {});
                _goToYourLocation();
              },
            ),
          ),
        ),

        // 🚨 Scrolling ListView Of Parking Places On Map 🚨
        Positioned(
          bottom: 10,
          width: SizeConfig.width,
          height: SizeConfig.height! * 0.2,
          child: ListAnimation(
              minimize: _minimize,
              height: SizeConfig.height! * 0.2,
              minHeight: SizeConfig.height! * 0.2 / 2,
              // 🚨 Getting Data From Date Base 🚨
              child: BlocConsumer<GarageBloc, GarageState>(
                listener: (context, state) {
                  if (state is LoadedDataState) {
                    _addMarkers(state.garages ?? []);
                  }
                },
                builder: (context, state) {
                  if (state is LoadedDataState) {
                    this.garages = state.garages;
                  } else if (state is LoadingDataState)
                    return SpinKitPumpingHeart(
                      color: Colors.red,
                      size: 75.0,
                    );

                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (pageIndex) async {
                        _isUserSwipe = true;
                        lat = garages![pageIndex].lat!;
                        long = garages![pageIndex].long!;
                        allMarkers.add(Marker(
                            rotation: 300,
                            icon: await BitmapDescriptor.fromAssetImage(
                                ImageConfiguration.empty,
                                "assets/map/marker1.png"),
                            markerId: MarkerId('second'),
                            position: LatLng(lat, long)));

                        setState(() {});
                        _goToYourLocation();
                        Future.delayed(Duration(seconds: 10)).asStream();

                        if (!_isUserSwipe) {
                          print('this');
                          return;
                        }
                        _isUserSwipe = false;
                      },
                      itemCount: garages?.length ?? 0,
                      itemBuilder: (context, i) {
                        return CardGarageItem(
                          garage: garages![i],
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
                },
              )),
        ),
      ]),
    );
  }

  

  @override
  void initState() {
    context.read<GarageBloc>().add(GetDataEvent());
    super.initState();
  }

  // 🚨 Function That Update New Camera Position For Maps 🚨
  void _addMarkers(List<Garage> garages) async {
    for (int i = 0; i < garages.length; i++) {
      allMarkers.add(Marker(
        onTap: () {
          _pageController.animateToPage(i,
              duration: Duration(milliseconds: 20), curve: Curves.easeIn);
        },
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'assets/map/garage3.png'),
        markerId: MarkerId('$i'),
        position: LatLng(garages[i].lat!, garages[i].long!),
      ));
    }
  }

  Future<void> _goToYourLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, long), zoom: 11)));
  }
}
