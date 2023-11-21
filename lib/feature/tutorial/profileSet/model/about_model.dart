import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_model.freezed.dart';

part 'about_model.g.dart';

@freezed
class AboutModel with _$AboutModel {
  const factory AboutModel({
    Data? data,
    Status? status,
  }) = _AboutModel;

  factory AboutModel.fromJson(Map<String, dynamic> json) =>
      _$AboutModelFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data() = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class Status with _$Status {
  const factory Status({
    String? type,
    String? message,
    String? description,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
