import 'dart:convert';

import 'package:http/http.dart';
import 'package:parking_project/models/garage.dart';

class ParkingRepo {
  static final ParkingRepo _parkingRepo = ParkingRepo._();

  ParkingRepo._();

  factory ParkingRepo() => _parkingRepo;

  // 🚨 Json Function That Take Data And Fill up The List Of Markers 🚨
  Future<List<Garage>> getData() async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/garages';
    var response = await get(Uri.parse(url));
    Map map = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(map['data']);
      return (map['data'] as List)
          .map((e) => Garage.fromJson(e))
          .toList();
    }
    print(map);
    throw Exception('Error when get data');
  }
}

