import 'package:json_annotation/json_annotation.dart';

part 'send_otp_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SendOTPRequest {

  SendOTPRequest({this.userId, this.countryCode,this.mobile});

  factory SendOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$SendOTPRequestFromJson(json);
  String? userId;
  int? countryCode;
  int? mobile;

  Map<String, dynamic> toJson() => _$SendOTPRequestToJson(this);
}