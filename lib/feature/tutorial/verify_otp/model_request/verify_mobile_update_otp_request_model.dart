import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_mobile_update_otp_request_model.freezed.dart';
part 'verify_mobile_update_otp_request_model.g.dart';

@freezed
class VerifyMobileUpdateOTPRequestModel with _$VerifyMobileUpdateOTPRequestModel {
  const factory VerifyMobileUpdateOTPRequestModel({
    required String userId,
    required String otpId,
    required String otp,
    required bool isMobileUpdation
  }) = _VerifyMobileUpdateOTPRequestModel;

  factory VerifyMobileUpdateOTPRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyMobileUpdateOTPRequestModelFromJson(json);
}
