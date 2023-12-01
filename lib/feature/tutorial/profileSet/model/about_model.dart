import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_model.freezed.dart';
part 'about_model.g.dart';

@freezed
class AboutModel with _$AboutModel {
  factory AboutModel({
     Data? data,
     Status? status,
  }) = _AboutModel;

  factory AboutModel.fromJson(Map<String, dynamic> json) =>
      _$AboutModelFromJson(json);
}

@freezed
class Data with _$Data {
  factory Data({
     List<Item>? items,
     int? count,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class Item with _$Item {
  factory Item({
     int? id,
     String? title,
     String? content,
     String? role,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class Status with _$Status {
  factory Status({
     String? type,
     String? message,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
