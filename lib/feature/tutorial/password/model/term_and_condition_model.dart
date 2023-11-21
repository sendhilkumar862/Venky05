import 'package:freezed_annotation/freezed_annotation.dart';

part 'term_and_condition_model.freezed.dart';
part 'term_and_condition_model.g.dart';

@freezed
class TermAndConditionModel with _$TermAndConditionModel {
  const factory TermAndConditionModel({
     Data? data,
     Status? status,
  }) = _TermAndConditionModel;

  factory TermAndConditionModel.fromJson(Map<String, dynamic> json) =>
      _$TermAndConditionModelFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
     List<TermsItem>? items,
     int? count,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class TermsItem with _$TermsItem {
  const factory TermsItem({
     int? id,
     String? title,
     String? content,
  }) = _TermsItem;

  factory TermsItem.fromJson(Map<String, dynamic> json) =>
      _$TermsItemFromJson(json);
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
