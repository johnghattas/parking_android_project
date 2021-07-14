import 'package:flutter/material.dart';
import 'package:parking_project/repositers/camera_repo.dart';
import 'package:parking_project/widgets/floor_cameras.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CameraRepo _cameraRepo = CameraRepo();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: FloorCamera(
          floorId: 44,
          cameraRepo: _cameraRepo,
          getCameras: _cameraRepo.getCamerasById(floorId: 1),
        ),
      ),
    );
  }
}
