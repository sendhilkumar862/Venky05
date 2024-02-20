import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';



class LoginModel {

  LoginModel({this.token, this.username, this.status});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
    username = json['username'];
    status = json['status'];
  }
  Token? token;
  String? username;
  String? status;
}

class Token {

  Token(
      {this.accessToken,
        this.accessTokenExpiryTime,
        this.refreshToken,
        this.refreshTokenExpiryTime,
        this.role});

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    accessTokenExpiryTime = json['accessTokenExpiryTime'];
    refreshToken = json['refreshToken'];
    refreshTokenExpiryTime = json['refreshTokenExpiryTime'];
    role = json['role'];
  }
  String? accessToken;
  int? accessTokenExpiryTime;
  String? refreshToken;
  int? refreshTokenExpiryTime;
  String? role;
}