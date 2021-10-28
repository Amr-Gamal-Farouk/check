import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.employee,
    required this.manager,
    required this.mediaUrl,
    required this.postId,
    required this.timesTemp,
    required this.title,
  });

  String employee;
  String manager;
  String mediaUrl;
  String postId;
  Timestamp timesTemp;
  String title;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        employee: json["employee"],
        manager: json["manager"],
        mediaUrl: json["mediaUrl"],
        postId: json["postId"],
        timesTemp: json["timesTemp"],
        title: json["title"],
      );

  factory DataModel.fromSnapshot(Map data) => DataModel(
        employee: data["employee"],
        manager: data["manager"],
        mediaUrl: data["mediaUrl"],
        postId: data["postId"],
        timesTemp: data["timesTemp"],
        title: data["title"],
      );

  Map<String, dynamic> toJson() => {
        "employee": employee,
        "manager": manager,
        "mediaUrl": mediaUrl,
        "postId": postId,
        "timesTemp": timesTemp,
        "title": title,
      };
}
