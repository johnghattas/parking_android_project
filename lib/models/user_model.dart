import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';
@HiveType(typeId : 1)
class Client {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? phone;
  @HiveField(2)
  String? firstName;
  @HiveField(3)
  String? lastName;
  @HiveField(4)
  bool? isOwner = false;

  Client({
    required this.id,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.isOwner,
  });

  Client.fromMap(Map map) {
    this.id = map['id'];
    this.phone = map['phone'];
    this.firstName = map['first_name'];
    this.lastName = map['last_name'];
    this.isOwner = map['is_owner'] == 1;
  }

  Map toMap() {
    return {
      'id': this.id,
      'phone': this.phone,
      'first_name': this.firstName,
      'last_name': this.lastName,
      'is_owner': this.isOwner!?"1":"0",
    };
  }

  get name => '$firstName $lastName';

  void checkAsserts() {
    assert(phone != null && phone!.isNotEmpty);
    assert(firstName != null && firstName!.isNotEmpty);
    assert(lastName != null && lastName!.isNotEmpty);
    assert(id != null && id!.isNotEmpty);
    assert(isOwner != null);
  }
}
