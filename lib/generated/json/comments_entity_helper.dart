import 'package:parking_project/models/cameras_entity.dart';

commentsEntityFromJson(CamerasEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'] is String
				? int.tryParse(json['status'])
				: json['status'].toInt();
	}
	if (json['data'] != null) {
		data.data = (json['data'] as List).map((v) => CameraData().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> commentsEntityToJson(CamerasEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['data'] =  entity.data.map((v) => v.toJson()).toList();
	return data;
}

commentsDataFromJson(CameraData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['image'] != null) {
		data.image = json['image'].toString();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['floor_id'] != null) {
		data.floorId = json['floor_id'] is String
				? int.tryParse(json['floor_id'])
				: json['floor_id'].toInt();
	}
	return data;
}

Map<String, dynamic> commentsDataToJson(CameraData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['image'] = entity.image;
	data['title'] = entity.title;
	data['floor_id'] = entity.floorId;
	return data;
}