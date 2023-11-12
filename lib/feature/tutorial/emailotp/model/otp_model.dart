import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_model.freezed.dart';
part 'otp_model.g.dart';

@freezed
class OtpModel with _$OtpModel {
  const factory OtpModel({
     Data? data,
     Status? status,
  }) = _OtpModel;

  factory OtpModel.fromJson(Map<String, dynamic> json) =>
      _$OtpModelFromJson(json);
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
     dynamic id,
     dynamic status,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}


@freezed
class Status with _$Status {
  const factory Status({
     String? type,
     String? message,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
