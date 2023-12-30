import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_request_model.freezed.dart';
part 'verify_otp_request_model.g.dart';

@freezed
class VerifyOTPRequestModel with _$VerifyOTPRequestModel {
  const factory VerifyOTPRequestModel({
    required String userId,
    required String otpId,
    required String otp,
  }) = _VerifyOTPRequestModel;

  factory VerifyOTPRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOTPRequestModelFromJson(json);
}
