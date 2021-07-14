import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_project/models/floors_model.dart';
// import 'package:garage/Gui/floors_model.dart';
import 'package:parking_project/fetch.dart';
import 'package:parking_project/models/garage_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Edit extends StatefulWidget {
  final Model garage;
  const Edit({Key? key, required this.garage}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

// final _formKey = GlobalKey<FormState>();
Completer<GoogleMapController> _controller = Completer();

class _EditState extends State<Edit> {
  FetchApi fetchApi = FetchApi();
  TextEditingController _id = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _bNum = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _capacity = TextEditingController();
  TextEditingController _price = TextEditingController();
  double? lat;

  int i = 1;
  List<FloorsModel> _floorList = [];
  String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9wYXJraW5ncHJvamVjdGdwLmhlcm9rdWFwcC5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MjUxNjIyNjYsImV4cCI6MTYyNjYzMTA2NiwibmJmIjoxNjI1MTYyMjY2LCJqdGkiOiJKWDNjd1VNMWRzRU9BYmRQIiwic3ViIjoiNDJhS1V5YVdMRFZPamZGTzh3T0dET3hBTXZiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.iTiVBd5kS232ymMijEN6Uxek_hhFrxL-tinocgD0eXY';

  double? lng;
  final _formKey = GlobalKey<FormState>();
  List<Marker> _markers = [];

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal.shade700,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text('Data'),
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
                        controller: _capacity,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'please fill the fields';
                          }
                          return null;
                        },
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
                      SizedBox(height: 8,),
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
              Row(
                children: [
                  IconButton(onPressed: (){
                    getUserLocation();
                  },icon: Icon(Icons.center_focus_strong_outlined),
                   color: Colors.deepOrange, padding: EdgeInsets.symmetric(
                          horizontal: mq.width / 6, vertical: 5),
                  ),
                  TextButton(
                    child: Text(
                      'Done',style: TextStyle(color: Colors.deepOrange),
                    ),
                    onPressed: () => editData(widget.garage.id),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: mq.width / 6, vertical: 5),
                        textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),

              // GoogleMap(initialCameraPosition: _kInitialPosition, ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editData(id) async {
    if (_formKey.currentState!.validate()) {
      String name = _name.text;
      String city = _city.text;
      String street = _street.text;
      int bNumber = int.parse(_bNum.text);
      // int number = int.parse(_number.text);
      int capacity = int.parse(_capacity.text);
      int price  = int.parse(_price.text);
      bool hasSystem = true;
      bool private = false;

      Model model = Model(
          bNumber, city, hasSystem, name, private, street, lat, lng,price,[],);
      FetchApi api = FetchApi();
      bool isValid;
      try {
        isValid = await api.editData(model, token, id);
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
      } else
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Fail'),
        ));
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => FilledData()));
    }
    print('empty fields!');
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();
    _fillTextField();
  }

  Position? position;
  bool _isGetPoss = false;
  int _index = 0;

  void getUserLocation() async {
    if (!_isGetPoss) {
      position = await GeolocatorPlatform.instance
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      lat = position?.latitude;
      lng = position?.longitude;
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
    // setState(() {});
  }

  void _fillTextField() {
    _name.text = widget.garage.name ?? '';
    _city.text = widget.garage.city ?? '';
    _bNum.text = widget.garage.bNumber?.toString() ?? '';
    // _capacity.text = widget.garage.capacity?.toString() ?? '';
    _id.text = widget.garage.id?.toString() ?? '';
    _street.text = widget.garage.street ?? '';
    _price.text=widget.garage.price?.toString()??'';
   setState(() {
     _floorList = widget.garage.floor??[];
     i= _floorList.length == 0? 1 : _floorList.length;
   });
  }
}
