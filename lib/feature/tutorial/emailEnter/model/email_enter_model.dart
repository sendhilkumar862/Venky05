import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_enter_model.freezed.dart';
part 'email_enter_model.g.dart';

@freezed
abstract class EmailEnterModel with _$EmailEnterModel {
  const factory EmailEnterModel({
     Data? data,
     Status? status,
  }) = _EmailEnterModel;

  factory EmailEnterModel.fromJson(Map<String, dynamic> json) =>
      _$EmailEnterModelFromJson(json);
}

@freezed
abstract class Data with _$Data {
  const factory Data({
     Item? item,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
abstract class Item with _$Item {
  const factory Item({
     dynamic? userId,
     String? status,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
abstract class Status with _$Status {
  const factory Status({
     String? type,
     String? message,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
