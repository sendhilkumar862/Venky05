// To parse this JSON data, do
//
//     final emailArgModel = emailArgModelFromJson(jsonString);

import 'dart:convert';

EmailArgModel emailArgModelFromJson(String str) =>
    EmailArgModel.fromJson(json.decode(str));

String emailArgModelToJson(EmailArgModel data) => json.encode(data.toJson());

class EmailArgModel {
  String? email;

  EmailArgModel({
    this.email,
  });

  factory EmailArgModel.fromJson(Map<String, dynamic> json) => EmailArgModel(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
