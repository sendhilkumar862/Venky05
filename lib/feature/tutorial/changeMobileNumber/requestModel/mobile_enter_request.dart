import 'package:json_annotation/json_annotation.dart';

part 'mobile_enter_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class MobileEnterRequest {

  MobileEnterRequest({this.userId, this.countryCode,this.mobile,this.password});

  factory MobileEnterRequest.fromJson(Map<String, dynamic> json) =>
      _$MobileEnterRequestFromJson(json);
  String? userId;
  int? countryCode;
  int? mobile;
  String? password;

  Map<String, dynamic> toJson() => _$MobileEnterRequestToJson(this);
}