import 'package:parking_project/models/rectangles_entity.dart';

rectanglesEntityFromJson(RectanglesEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = (json['data'] as List).map((v) => RectanglesData().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> rectanglesEntityToJson(RectanglesEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['data'] =  entity.data.map((v) => v.toJson()).toList();
	return data;
}

rectanglesDataFromJson(RectanglesData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['x1'] != null) {
		data.x1 = json['x1'] is String
				? int.tryParse(json['x1'])
				: json['x1'].toInt();
	}
	if (json['y1'] != null) {
		data.y1 = json['y1'] is String
				? int.tryParse(json['y1'])
				: json['y1'].toInt();
	}
	if (json['x2'] != null) {
		data.x2 = json['x2'] is String
				? int.tryParse(json['x2'])
				: json['x2'].toInt();
	}
	if (json['y2'] != null) {
		data.y2 = json['y2'] is String
				? int.tryParse(json['y2'])
				: json['y2'].toInt();
	}
	if (json['position'] != null) {
		data.position = json['position'] is String
				? int.tryParse(json['position'])
				: json['position'].toInt();
	}
	if (json['is_available'] != null) {
		data.isAvailable = json['is_available'] is String
				? int.tryParse(json['is_available'])
				: json['is_available'].toInt();
	}
	if (json['camera_id'] != null) {
		data.cameraId = json['camera_id'] is String
				? int.tryParse(json['camera_id'])
				: json['camera_id'].toInt();
	}
	return data;
}

Map<String, dynamic> rectanglesDataToJson(RectanglesData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['x1'] = entity.x1;
	data['y1'] = entity.y1;
	data['x2'] = entity.x2;
	data['y2'] = entity.y2;
	data['position'] = entity.position;
	data['is_available'] = entity.isAvailable;
	data['camera_id'] = entity.cameraId;
	return data;
}