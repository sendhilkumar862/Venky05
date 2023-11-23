import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_model.g.dart';

ResponseSuccessModel responseSuccessModelFromJson(String str) =>
    ResponseSuccessModel.fromJson(json.decode(str));

@JsonSerializable()
class ResponseSuccessModel {
  Data? data;
  Status? status;

  ResponseSuccessModel({
    this.data,
    this.status,
  });

  factory ResponseSuccessModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseSuccessModelFromJson(json);
}

@JsonSerializable()
class Data {
  String? item;

  Data({
    this.item,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@JsonSerializable()
class Status {
  String? type;
  String? message;

  Status({
    this.type,
    this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
