import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_model.freezed.dart';
part 'verification_model.g.dart';

@freezed
class VerificationModel with _$VerificationModel {
  const factory VerificationModel({
    required Data data,
    required Status status,
  }) = _VerificationModel;

  factory VerificationModel.fromJson(Map<String, dynamic> json) =>
      _$VerificationModelFromJson(json);
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
    required int otpId,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class Status with _$Status {
  const factory Status({
    required String type,
    required String message,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
