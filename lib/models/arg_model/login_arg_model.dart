// To parse this JSON data, do
//
//     final userLoginArgModel = userLoginArgModelFromJson(jsonString);

import 'dart:convert';

UserLoginArgModel userLoginArgModelFromJson(String str) => UserLoginArgModel.fromJson(json.decode(str));

String userLoginArgModelToJson(UserLoginArgModel data) => json.encode(data.toJson());

class UserLoginArgModel {
  String? email;
  String? password;

  UserLoginArgModel({
    this.email,
    this.password,
  });

  factory UserLoginArgModel.fromJson(Map<String, dynamic> json) => UserLoginArgModel(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
