// To parse this JSON data, do
//
//     final userLoginResponseModel = userLoginResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_model.g.dart';

UserLoginResponseModel userLoginResponseModelFromJson(String str) =>
    UserLoginResponseModel.fromJson(json.decode(str));

String userLoginResponseModelToJson(UserLoginResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class UserLoginResponseModel {
  Data? data;
  Status? status;

  UserLoginResponseModel({
    this.data,
    this.status,
  });

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  Item? item;

  Data({
    this.item,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Item {
  String? accessToken;
  int? accessTokenExpiryTime;
  String? refreshToken;
  int? refreshTokenExpiryTime;

  Item({
    this.accessToken,
    this.accessTokenExpiryTime,
    this.refreshToken,
    this.refreshTokenExpiryTime,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
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

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}
