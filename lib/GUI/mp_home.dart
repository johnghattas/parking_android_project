import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapHome extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapHome> {
  List<Marker> _allMarkers = [];
  double lat = 0.0;
  double long = 0.0;
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Button For Getting Your Current Location
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.my_location),
        onPressed: () async {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          _allMarkers.add(Marker(
              markerId: MarkerId('first'),
              position: LatLng(position.latitude, position.longitude)));
          lat = position.latitude;
          long = position.longitude;
          setState(() {});
          goToYourLocation();
        },
      ),
      // Body Of Google Maps Design
      body: Container(
        child: GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
              target: LatLng(30.14254528772857, 31.324295242328564), zoom: 11),
          markers: Set.from(_allMarkers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }

  Future getData() async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/garages';
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    for (int i = 0; i < responseBody['data'].length; i++) {
      _allMarkers.add(
        Marker(
            markerId: MarkerId('$i'),
            position: LatLng(double.parse(responseBody['data'][i]['lat']),
                double.parse(responseBody['data'][i]['long']))),
      );
    }
    if (!mounted) return;
    setState(() {});
    return responseBody;
  }

  Future<void> goToYourLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, long), zoom: 18)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
}
