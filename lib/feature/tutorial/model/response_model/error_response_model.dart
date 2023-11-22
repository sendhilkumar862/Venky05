// To parse this JSON data, do
//
//     final errorResponseModel = errorResponseModelFromJson(jsonString);

import 'dart:convert';

ErrorResponseModel errorResponseModelFromJson(String str) =>
    ErrorResponseModel.fromJson(json.decode(str));

String errorResponseModelToJson(ErrorResponseModel data) =>
    json.encode(data.toJson());

class ErrorResponseModel {
  Data? data;
  Status? status;

  ErrorResponseModel({
    this.data,
    this.status,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status?.toJson(),
      };
}

class Data {
  Item? item;

  Data({
    this.item,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "item": item?.toJson(),
      };
}

class Item {
  Item();

  factory Item.fromJson(Map<String, dynamic> json) => Item();

  Map<String, dynamic> toJson() => {};
}

class Status {
  String? type;
  String? message;
  String? description;

  Status({
    this.type,
    this.message,
    this.description,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        type: json["type"],
        message: json["message"],
        description: json["description"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "description": description,
      };
}
