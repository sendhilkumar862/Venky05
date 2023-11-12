// To parse this JSON data, do
//
//     final responseSuccessModel = responseSuccessModelFromJson(jsonString);

import 'dart:convert';

ResponseSuccessModel responseSuccessModelFromJson(String str) =>
    ResponseSuccessModel.fromJson(json.decode(str));

String responseSuccessModelToJson(ResponseSuccessModel data) =>
    json.encode(data.toJson());

class ResponseSuccessModel {
  Data? data;
  Status? status;

  ResponseSuccessModel({
    this.data,
    this.status,
  });

  factory ResponseSuccessModel.fromJson(Map<String, dynamic> json) =>
      ResponseSuccessModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status?.toJson(),
      };
}

class Data {
  String? item;

  Data({
    this.item,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        item: json["item"],
      );

  Map<String, dynamic> toJson() => {
        "item": item,
      };
}

class Status {
  String? type;
  String? message;

  Status({
    this.type,
    this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        type: json["type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
      };
}
