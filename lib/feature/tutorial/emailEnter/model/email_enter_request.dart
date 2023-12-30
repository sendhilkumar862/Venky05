import 'package:json_annotation/json_annotation.dart';

part 'email_enter_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EmailEnterRequest {

  EmailEnterRequest({this.email, this.role});

  factory EmailEnterRequest.fromJson(Map<String, dynamic> json) =>
      _$EmailEnterRequestFromJson(json);
  String? email;
  String? role;

  Map<String, dynamic> toJson() => _$EmailEnterRequestToJson(this);
}