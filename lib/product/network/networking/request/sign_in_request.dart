
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SingInRequest {

  SingInRequest({this.email, this.password});

  factory SingInRequest.fromJson(Map<String, dynamic> json) =>
      _$SingInRequestFromJson(json);
  String? email;
  String? password;

  Map<String, dynamic> toJson() => _$SingInRequestToJson(this);
}