import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class ChangePasswordRequest {

  ChangePasswordRequest({this.oldPassword,this.newPassword,this.retypedPassword});

  String? oldPassword;
  String? newPassword;
  String? retypedPassword;

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}