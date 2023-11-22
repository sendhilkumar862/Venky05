// To parse this JSON data, do
//
//     final resetPassEmailRespnoseModel = resetPassEmailRespnoseModelFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

ResetPassEmailResponseModel resetPassEmailRespnoseModelFromJson(String str) =>
    ResetPassEmailResponseModel.fromJson(json.decode(str));

String resetPassEmailRespnoseModelToJson(ResetPassEmailResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ResetPassEmailResponseModel {
  Data? data;
  Status? status;

  ResetPassEmailResponseModel({
    this.data,
    this.status,
  });

  factory ResetPassEmailResponseModel.fromJson(Map<String, dynamic> json) =>
      ResetPassEmailResponseModel(
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
        item: json["item"].length > 0 ? json["item"] : '',
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
