import 'package:parking_project/generated/json/base/json_convert_content.dart';
import 'package:parking_project/generated/json/base/json_field.dart';

class RectanglesEntity with JsonConvert<RectanglesEntity> {
	late List<RectanglesData> data;
}

class RectanglesData with JsonConvert<RectanglesData> {
	late int id;
	late int x1;
	late int y1;
	late int x2;
	late int y2;
	late int position;
	@JSONField(name: "is_available")
	late int isAvailable;
	@JSONField(name: "camera_id")
	late int cameraId;
}
