import 'package:json_annotation/json_annotation.dart';

part 'mobile_enter_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MobileEnterRequest {

  MobileEnterRequest({this.userId, this.countryCode,this.mobile});

  factory MobileEnterRequest.fromJson(Map<String, dynamic> json) =>
      _$MobileEnterRequestFromJson(json);
  String? userId;
  int? countryCode;
  int? mobile;

  Map<String, dynamic> toJson() => _$MobileEnterRequestToJson(this);
}