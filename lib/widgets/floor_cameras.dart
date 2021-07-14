import 'dart:async';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:parking_project/models/cameras_entity.dart';
import 'package:parking_project/models/rectangles_entity.dart';
import 'package:parking_project/repositers/camera_repo.dart';

class FloorCamera extends StatelessWidget {
  const FloorCamera(
      {Key? key,
      required this.floorId,
      required this.getCameras,
      required this.cameraRepo})
      : super(key: key);
  final int floorId;
  final Future<CamerasEntity> getCameras;
  final CameraRepo cameraRepo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CamerasEntity>(
      future: getCameras,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            child: Text('data error ${snapshot.error}'),
          );
        }

        if (snapshot.hasData) {
          final cameras = snapshot.data?.data;
          if (cameras == null) {
            return Text('no data');
          }
          return SizedBox(
            height: 250,
            child: ListView.builder(
              // padding: EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: cameras.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<RectanglesEntity>(
                    future: cameraRepo.getRectanglesByCameraId(
                        cameraId: cameras[index].id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          child: Text('rectangles error ${snapshot.error}'),
                        );
                      }

                      if (snapshot.hasData) {
                        List<RectanglesData> rectangles = snapshot.data?.data ?? [];
                        if(cameras[index].id == 44){
                          print(rectangles[0].isAvailable);
                        }
                        return FutureBuilder<Image>(
                          future: _generate(cameras[index].image, rectangles),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error');
                            }
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      child: snapshot.data,
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Expanded(flex: 1,child: Text(
                                    cameras[index].title,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: const Color(0xff00676d),
                                      letterSpacing: 1.072,
                                      height: 1.125,
                                    ),
                                    textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                    textAlign: TextAlign.left,
                                  )),
                                ],

                              );
                            }

                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      }
                      return Center(child: RefreshProgressIndicator(),);
                    },
                  ),
                );
              },
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<Image> _generate(
      String imageUrl, List<RectanglesData> rectangles) async {
    ui.Image _uiImage = await getImage(imageUrl);
    ui.PictureRecorder recorder = new ui.PictureRecorder();
    Canvas c = new Canvas(
        recorder,
        Rect.fromLTWH(
            0, 0, _uiImage.width.toDouble(), _uiImage.height.toDouble()));
    c.drawImage(_uiImage, Offset(0, 0), Paint());
    var rect = new Rect.fromLTWH(
        0.0, 0.0, _uiImage.width.toDouble(), _uiImage.height.toDouble());
    c.clipRect(rect);




    final offset = new Offset(40, 40);
    for (int i = 0; i < rectangles.length; i++) {
      final paint = new Paint();
      paint.color = rectangles[i].isAvailable == 0 ?Colors.green: Colors.red;
      paint.style = PaintingStyle.fill;
      c.drawRect(
          Rect.fromPoints(
              Offset(rectangles[i].x1.toDouble() - 20.0, rectangles[i].y1.toDouble()),
              Offset(rectangles[i].x2.toDouble() + 20.0, rectangles[i].y2.toDouble())), paint );
    }
    var picture = recorder.endRecording();

    final pngBytes =
        await (await picture.toImage(_uiImage.width, _uiImage.height))
            .toByteData(format: ui.ImageByteFormat.png);

    //Aim #1. Upade _image with generated image.
    var image = Image.memory(pngBytes!.buffer.asUint8List(),
        width: 300, height: 200, fit: BoxFit.fill);
    return image;

    //new Image.memory(pngBytes.buffer.asUint8List());
    // _image = new Image.network(
    //   'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
    // );

    //Aim #2. Write image to file system.
    //writeImage(pngBytes);
    //Make a temporary file (see elsewhere on SO) and writeAsBytes(pngBytes.buffer.asUInt8List())
  }

  Future<ui.Image> getImage(String path) async {
    Completer<ImageInfo> completer = Completer();
    var img = new CachedNetworkImageProvider( path);
    img
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }
}
