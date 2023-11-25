import 'dart:convert';

PreferenceRequest preferenceRequestFromJson(String str) =>
    PreferenceRequest.fromJson(json.decode(str));

String preferenceRequestToJson(PreferenceRequest data) =>
    json.encode(data.toJson());

class PreferenceRequest {
  final List<String>? grade;
  final List<String>? schoolType;
  final List<String>? subject;
  final List<String>? curriculum;

  PreferenceRequest({
    this.grade,
    this.schoolType,
    this.subject,
    this.curriculum,
  });

  factory PreferenceRequest.fromJson(Map<String, dynamic> json) =>
      PreferenceRequest(
        grade: json["grade"] == null
            ? []
            : List<String>.from(json["grade"]!.map((x) => x)),
        schoolType: json["schoolType"] == null
            ? []
            : List<String>.from(json["schoolType"]!.map((x) => x)),
        subject: json["subject"] == null
            ? []
            : List<String>.from(json["subject"]!.map((x) => x)),
        curriculum: json["curriculum"] == null
            ? []
            : List<String>.from(json["curriculum"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "grade": grade == null ? [] : List<dynamic>.from(grade!.map((x) => x)),
        "schoolType": schoolType == null
            ? []
            : List<dynamic>.from(schoolType!.map((x) => x)),
        "subject":
            subject == null ? [] : List<dynamic>.from(subject!.map((x) => x)),
        "curriculum": curriculum == null
            ? []
            : List<dynamic>.from(curriculum!.map((x) => x)),
      };
}
