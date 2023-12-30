import 'package:json_annotation/json_annotation.dart';

part 'mobile_enter_request.g.dart';

@JsonSerializable()
class MobileEnterRequest {

  MobileEnterRequest({this.userId, this.countryCode,this.mobile});

  factory MobileEnterRequest.fromJson(Map<String, dynamic> json) =>
      _$MobileEnterRequestFromJson(json);
  String? userId;
  String? countryCode;
  String? mobile;

  Map<String, dynamic> toJson() => _$MobileEnterRequestToJson(this);
}