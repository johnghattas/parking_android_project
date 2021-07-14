import 'dart:convert';

import 'package:http/http.dart';
import 'package:parking_project/const_data.dart';
import 'package:parking_project/models/cameras_entity.dart';
import 'package:parking_project/models/rectangles_entity.dart';
import '../const_data.dart';
class CameraRepo{

  Future<CamerasEntity> getCamerasById({required int floorId}) async {

    Response response = await get(Uri.parse(cUrl + '/floorCameras/$floorId'), headers: {
      'accept' : 'application/json'
    });

    print(response.body);
    if(response.statusCode == 200){
      Map<String, dynamic> map = jsonDecode(response.body);


      return CamerasEntity().fromJson(map);
    }

    throw Exception('Un handling exception');
  }

  Future<RectanglesEntity> getRectanglesByCameraId({required int cameraId}) async {

    Response response = await get(Uri.parse(cUrl + '/rectangle/$cameraId'), headers: {
      'accept' : 'application/json'
    });

    print(response.body);

    if(response.statusCode == 200){
      Map<String, dynamic> map = jsonDecode(response.body);

      return RectanglesEntity().fromJson(map);
    }

    throw Exception('Un handling exception');
  }


}