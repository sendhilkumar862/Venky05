import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'preference_model.g.dart';

PreferenceModel preferenceModelFromJson(String str) =>
    PreferenceModel.fromJson(json.decode(str));

String preferenceModelToJson(PreferenceModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class PreferenceModel {
  Data? data;
  Status? status;

  PreferenceModel({
    this.data,
    this.status,
  });

  factory PreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$PreferenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PreferenceModelToJson(this);
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
  List<Curriculum>? grade;
  List<Curriculum>? schoolType;
  List<Curriculum>? curriculum;
  List<Curriculum>? subject;

  Item({
    this.grade,
    this.schoolType,
    this.curriculum,
    this.subject,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Curriculum {
  int? id;
  String? value;
  bool? isEnabled;

  Curriculum({
    this.id,
    this.value,
    this.isEnabled,
  });

  factory Curriculum.fromJson(Map<String, dynamic> json) =>
      _$CurriculumFromJson(json);

  Map<String, dynamic> toJson() => _$CurriculumToJson(this);
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
