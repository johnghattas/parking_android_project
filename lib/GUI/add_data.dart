import 'dart:async';
import 'package:flutter/material.dart';
import 'package:parking_project/models/floors_model.dart';
// import 'package:garage/Gui/floors_model.dart';
import 'package:parking_project/fetch.dart';
import 'package:parking_project/models/garage_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();
  Completer<GoogleMapController> _controller = Completer();

   int i=1;
  TextEditingController _name = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _bNum = TextEditingController();
  TextEditingController _capacity = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _price = TextEditingController();
  double? lat ;
  double? lng;


  List<FloorsModel> _floorList = [FloorsModel.init()];
  // List<TextEditingController> _controllers = [];

  // late GoogleMapController mapController;
  
  List<Marker> _markers = [];



  @override
  Widget build(BuildContext context) {

    var mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () => _addData(),
        ),
      ],backgroundColor: Colors.teal.shade700,
        elevation: 0.0,
        title: Text('Data'),
        leading:GestureDetector(child: Icon(Icons.arrow_back),
        onTap: ()=>Navigator.pop(context),),

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              right: mq.width * 0.05,
              left: mq.width * 0.05,
              top: mq.width * 0.02),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.02),
              ),

              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _name,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'please fill the fields';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Parking name',
                            labelStyle: TextStyle(
                              color: Colors.teal.shade500,
                            ),
                            icon: Icon(
                              Icons.local_parking,
                              color: Colors.deepOrange,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal.shade500))),
                      ),
                      TextFormField(
                        controller: _city,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'please fill the fields';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'City',
                            labelStyle: TextStyle(
                              color: Colors.teal.shade500,
                            ),
                            icon: Icon(
                              Icons.location_city,
                              color: Colors.deepOrange,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal.shade500))),
                      ),
                      TextFormField(
                        controller: _street,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'please fill the fields';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Street',
                            labelStyle: TextStyle(
                              color: Colors.teal.shade500,
                            ),
                            icon: Icon(
                              Icons.add_road,
                              color: Colors.deepOrange,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal.shade500))),
                      ),
                      TextFormField(
                        controller: _bNum,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'please fill the fields';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'build number',
                            labelStyle: TextStyle(
                              color: Colors.teal.shade500,
                            ),
                            icon: Icon(
                              Icons.confirmation_number,
                              color: Colors.deepOrange,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal.shade500))),
                      ),

                      TextFormField(
                        controller: _price,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'please fill the fields';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'price ',
                            labelStyle: TextStyle(
                              color: Colors.teal.shade500,
                            ),
                            icon: Icon(
                              Icons.money_off,
                              color: Colors.deepOrange,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal.shade500))),
                      ),
                      SizedBox(height: 8),
                      Container(padding: EdgeInsets.only(right: 15.0,bottom: 10),decoration: BoxDecoration(borderRadius:BorderRadius.circular(10) ,
                          color: Colors.grey.shade200,shape:BoxShape.rectangle,boxShadow: [BoxShadow(
                          )] ),
                          child:ListView.builder(itemCount:i ,shrinkWrap: true,itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    // controller: _capacity,
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        return 'please fill the fields';
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) => _floorList[index].capacity = int.parse(newValue??'0'),
                                    decoration: InputDecoration(
                                        labelText: 'Capacity',
                                        labelStyle: TextStyle(
                                          color: Colors.teal.shade500,
                                        ),
                                        icon: Icon(
                                          Icons.reduce_capacity,
                                          color: Colors.deepOrange,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.teal.shade500))),
                                  ),

                                ),


                                Expanded(
                                  child: TextFormField(
                                    // controller: _number,
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        return 'please fill the fields';
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) => _floorList[index].number = int.parse(newValue??'0'),

                                    decoration: InputDecoration(
                                        labelText: 'number',
                                        labelStyle: TextStyle(
                                          color: Colors.teal.shade500,
                                        ),
                                        icon: Icon(
                                          Icons.reduce_capacity,
                                          color: Colors.deepOrange,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.teal.shade500))),
                                  ),
                                ),

                              ],
                            );
                          },)
                      ),
                      Padding(padding: EdgeInsets.only(top: 8),),
                      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                        AnimatedContainer(duration: Duration(milliseconds: 500),decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),),
                          child: Card(
                            child: IconButton(onPressed: (){

                              _floorList.add(FloorsModel.init());

                              setState(() {
                                if(i<5)
                                i++;
                              });
                            }, icon: Icon(Icons.add,color: Colors.deepOrange,)
                            ),
                          ),
                        ),
                        Container(decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),),
                          child: Card(
                            child: IconButton(onPressed: (){
                              _floorList.removeLast();

                              setState(() {
                                if(i>1)
                                i--;

                              });
                            }, icon: Icon(Icons.minimize,color: Colors.deepOrange,)),
                          ),
                        ),
                      ],)
                    ],
                  )),

              Padding(padding: EdgeInsets.only(top: 20.0)),
              SizedBox(
                height: 150,
                width: double.infinity,
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    // if (!_controller.isCompleted)
                    _controller.complete(controller);
                  },
                  markers: Set.of(_markers),
                  initialCameraPosition: CameraPosition(
                      target: LatLng(position?.latitude ?? 30.14256,
                          position?.longitude ?? 31.14256),
                      zoom: 14.0),
                ),
              ),
              IconButton(onPressed: (){
                getUserLocation();
              },icon: Icon(Icons.center_focus_strong_outlined),
                color: Colors.deepOrange, padding: EdgeInsets.symmetric(
                    horizontal: mq.width / 6, vertical: 5),
              ),
              // GoogleMap(initialCameraPosition: _kInitialPosition, ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();

    // _floorList.add(FloorsModel.init());

  }

  Position? position;
  bool _isGetPoss = false;
  int _index = 0;
  void getUserLocation() async {
    if (!_isGetPoss) {
      position = await GeolocatorPlatform.instance
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      lat=position?.latitude;
      lng=position?.longitude;

    }

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position!.latitude, position!.longitude), zoom: 14)));
    var markers2 = [
      Marker(
          onTap: () {
            print('Tapped');
          },
          draggable: true,
          markerId: MarkerId('Marker$_index'),
          position: LatLng(
              position?.latitude ?? 30.14256, position?.longitude ?? 31.14256),
          onDragEnd: ((newPosition) {
            lat = newPosition.latitude;
            lng = newPosition.longitude;
          }))
    ];


      // MarkerUpdates.from(Set.of(_markers), Set.of(markers2));


      //initial marker
      // var marker = _markers[0];

      _markers = markers2;
    _isGetPoss = true;
    _index++;
    setState(() {});

  }

  Future<void> _addData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_floorList[0].capacity);
      print(_floorList[0].number);
      print(_floorList[1].capacity);
      String name = _name.text;
      String city = _city.text;
      String street = _street.text;
      int bNumber = int.parse(_bNum.text);
      // List<FloorsModel> floor= _floorList;
      // int number = int.parse(_number.text);
      // int capacity = int.parse(_capacity.text);
      bool hasSystem = true;
      bool private = false;
      int price = int.parse(_price.text);


      // print(city);
      FetchApi api = FetchApi();
      Model model = Model(
        bNumber,city, hasSystem, name, private, street,lat, lng,price,_floorList);

      bool isValid;
      try {
        isValid = await api.addData(model,
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9wYXJraW5ncHJvamVjdGdwLmhlcm9rdWFwcC5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MjUxNjExNzYsImV4cCI6MTYyNjYyOTk3NiwibmJmIjoxNjI1MTYxMTc2LCJqdGkiOiJPcWNNV3VoN0dqbnR2OENlIiwic3ViIjoiNDJhS1V5YVdMRFZPamZGTzh3T0dET3hBTXZiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.Vzap7WOVtK7dIlF-K2-0rJ7jtdKyi7sI7S0H0yWZS4E');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
        return;
      }
      if (isValid) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('successful'),

        ));
        Navigator.pop(context);
      } else
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Fail'),
        ));
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => FilledData()));
    }
  }}