// To parse this JSON data, do
//
//     final resetPassEmailRespnoseModel = resetPassEmailRespnoseModelFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

ResetPassEmailRespnoseModel resetPassEmailRespnoseModelFromJson(String str) =>
    ResetPassEmailRespnoseModel.fromJson(json.decode(str));

String resetPassEmailRespnoseModelToJson(ResetPassEmailRespnoseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ResetPassEmailRespnoseModel {
  Data? data;
  Status? status;

  ResetPassEmailRespnoseModel({
    this.data,
    this.status,
  });

  factory ResetPassEmailRespnoseModel.fromJson(Map<String, dynamic> json) =>
      ResetPassEmailRespnoseModel(
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
