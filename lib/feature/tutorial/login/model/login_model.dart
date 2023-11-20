import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.freezed.dart';
part 'login_model.g.dart';

@freezed
class LoginModel with _$LoginModel {
  const factory LoginModel({
     Data? data,
     Status? status,
  }) = _LoginModel;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
     Item? item,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class Item with _$Item {
  const factory Item({
     Token? token,
     String? status,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class Token with _$Token {
  const factory Token({
     String? accessToken,
     int? accessTokenExpiryTime,
     String? refreshToken,
     int? refreshTokenExpiryTime,
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}

@freezed
class Status with _$Status {
  const factory Status({
     String? type,
     String? message,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}