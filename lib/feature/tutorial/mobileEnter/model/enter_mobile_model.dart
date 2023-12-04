import 'package:freezed_annotation/freezed_annotation.dart';

part 'enter_mobile_model.freezed.dart';
part 'enter_mobile_model.g.dart';

@freezed
class EnterMobileModel with _$EnterMobileModel {
  const factory EnterMobileModel({
     Data? data,
     Status? status,
  }) = _EnterMobileModel;

  factory EnterMobileModel.fromJson(Map<String, dynamic> json) =>
      _$EnterMobileModelFromJson(json);
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
      int? otpId,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class Status with _$Status {
  const factory Status({
     String? type,
     String? message,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) =>
      _$StatusFromJson(json);
}
