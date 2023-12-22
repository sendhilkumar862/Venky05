import 'package:json_annotation/json_annotation.dart';

part 'add_mobile_enter_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class AddMobileEnterRequest {

  AddMobileEnterRequest({this.userId, this.countryCode,this.mobile});

  factory AddMobileEnterRequest.fromJson(Map<String, dynamic> json) =>
      _$AddMobileEnterRequestFromJson(json);
  String? userId;
  int? countryCode;
  int? mobile;


  Map<String, dynamic> toJson() => _$AddMobileEnterRequestToJson(this);
}