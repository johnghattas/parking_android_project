import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:parking_project/fetch.dart';
import 'package:parking_project/garage_model.dart';
import 'package:parking_project/shared/screen_sized.dart';

class FilledData extends StatefulWidget {
  @override
  _FilledDataState createState() => _FilledDataState();
}

class _FilledDataState extends State<FilledData> {
  String? token;

  final FetchApi fetchApi = FetchApi();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Box box = Hive.box('user_data');
    token = box.get('token');
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return FutureBuilder(
      future: fetchApi.getData(token ?? ''),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        if (snapshot.hasData) {
          List<Model> garages = snapshot.data;
          return RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                    garages.length,
                    (index) => Center(
                          child: Container(
                            height: getProportionateScreenWidth(250),
                            width: mq.width - 20,
                            child: CardItem(
                              garage: garages[index],
                            ),
                          ),
                        )),
              ),
            ),
          );
        }
        return Container(
            height: double.infinity,
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

class CardItem extends StatelessWidget {
  final Model garage;

  const CardItem({Key? key, required this.garage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.grey,
        margin: EdgeInsets.all(3.0),
        elevation: 15.0,
        child: SizedBox(
          child: Column(
            children: [
              DefaultTextStyle(
                  style: TextStyle(
                      color: Colors.indigo.shade900,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 50.0,
                                      width: getProportionateScreenWidth(130),
                                      child: Card(
                                        child: Center(
                                          child: Text(
                                            'Parking name',
                                            style: TextStyle(
                                                color: Colors.indigo.shade900,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        margin: EdgeInsets.all(8.0),
                                        elevation: 8.0,
                                      ),
                                    ),
                                    Text(
                                      '${garage.name}',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 50.0,
                                      width: 130,
                                      child: Card(
                                        child: Center(
                                          child: Text(
                                            'Address',
                                            style: TextStyle(
                                                color: Colors.indigo.shade900,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        margin: EdgeInsets.all(8.0),
                                        elevation: 8.0,
                                      ),
                                    ),
                                    Text(
                                      '{${garage.bNumber},',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      ' ${garage.street},st.',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      ', ${garage.city},}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 50.0,
                                      width: 130,
                                      child: Card(
                                        child: Center(
                                          child: Text(
                                            'Capacity',
                                            style: TextStyle(
                                                color: Colors.indigo.shade900,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        margin: EdgeInsets.all(8.0),
                                        elevation: 8.0,
                                      ),
                                    ),
                                    Text(
                                      '${garage.capacity}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: CircularProgressIndicator(
                                            value: (garage.capacity! *
                                                0.5 /
                                                (garage.capacity! * 100) *
                                                garage.bNumber!),
                                            backgroundColor:
                                                Colors.amber.shade700,
                                            strokeWidth: 10.0,
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.centerLeft,
                          )
                        ],
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 40.0, top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //filled
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        height: 40.0,
                        width: 140.0,
                        child: Card(
                          elevation: 8.0,
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                                '${garage.capacity! * 0.5 / garage.capacity! * garage.bNumber!}%'),
                          ),
                        ),
                      ),
                    ),
                    //free
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        height: 40.0,
                        width: 140.0,
                        child: Card(
                          elevation: 8.0,
                          color: Colors.amber.shade700,
                          child: Center(
                            child: Text(
                                '${100 - garage.capacity! * 0.5 / garage.capacity! * garage.bNumber!}%'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

// Container(
//
//     width: 280,
//     height: 80,
//     child: Padding(
//       padding: const EdgeInsets.all(2.0),
//       child:new Sparkline(
//         data: [garages[index].capacity!/50,garages[index].capacity!/2
//       ,garages[index].capacity!/15,garages[index].capacity!/5,
//           garages[index].bNumber!/12,garages[index].capacity!/15,garages[index].capacity!/15],
//         lineWidth: 3.0,
//         pointColor: Colors.black,
//         fillMode: FillMode.below,
//         fillGradient: new LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Colors.amber[800]!, Colors.amber[200]!],
//         ),
//       ),
//     ),
// ),
