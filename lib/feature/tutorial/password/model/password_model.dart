import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'password_model.freezed.dart';
part 'password_model.g.dart';

@freezed
class PasswordModel with _$PasswordModel {
  const factory PasswordModel({
    required Data data,
    required Status status,
  }) = _PasswordModel;

  factory PasswordModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordModelFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    required Item item,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class Item with _$Item {
  const factory Item({
    required Token token,
    required String status,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class Token with _$Token {
  const factory Token({
    required String accessToken,
    required int accessTokenExpiryTime,
    required String refreshToken,
    required int refreshTokenExpiryTime,
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}

@freezed
class Status with _$Status {
  const factory Status({
    required String type,
    required String message,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
