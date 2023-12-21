import 'package:hessah/Request/change_password_request.dart';
import 'package:hessah/core/backend_service.dart';
import 'package:hessah/core/base_response.dart';

import '../../../../core/api_end_points.dart';
import '../../../../core/base_request.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';


class ChangePasswordRepository{
  Future<BaseResponse> passwordChange(
      {required String oldPassword, required String newPassword,required String retypedPassword}) async {
    try {
      return await BackendService.post(
          ChangeNameAPIRequest(oldPassword:oldPassword,newPassword:newPassword,retypedPassword:retypedPassword));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class ChangeNameAPIRequest extends BaseRequest {
  ChangeNameAPIRequest({required this.oldPassword, required this.newPassword,required this.retypedPassword});
  final String oldPassword;
  final String newPassword;
  final String retypedPassword;
  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.CHANGE_PASSWORD);
  @override
  Map<String, dynamic> get body => ChangePasswordRequest(oldPassword: oldPassword, newPassword: newPassword, retypedPassword: retypedPassword).toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.PUT;
}