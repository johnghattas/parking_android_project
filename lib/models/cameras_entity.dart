import 'package:parking_project/generated/json/base/json_convert_content.dart';
import 'package:parking_project/generated/json/base/json_field.dart';

class CamerasEntity with JsonConvert<CamerasEntity> {
	late int status;
	late List<CameraData> data;
}

class CameraData with JsonConvert<CameraData> {
	late int id;
	late String image;
	late String title;
	@JSONField(name: "floor_id")
	late int floorId;
}
