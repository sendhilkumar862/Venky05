import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_model.freezed.dart';
part 'password_model.g.dart';

@freezed
class PasswordModel with _$PasswordModel {
  const factory PasswordModel({
    required Token token,
    required String status,
    String? username
  }) = _PasswordModel;

  factory PasswordModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordModelFromJson(json);
}

@freezed
class Token with _$Token {
  const factory Token({
    required String accessToken,
    required int accessTokenExpiryTime,
    required String refreshToken,
    required int refreshTokenExpiryTime,
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}
