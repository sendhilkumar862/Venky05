

import 'package:hessah/core/api_end_points.dart';
import 'package:hessah/core/backend_service.dart';
import 'package:hessah/core/base_request.dart';
import 'package:hessah/core/base_response.dart';

import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';


class ChangeNameRepository{
  Future<BaseResponse> nameChange(
      {required String firstName, required String lastName}) async {
    try {
      return await BackendService.post(
          ChangeNameAPIRequest(firstName:firstName,lastName:lastName));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class ChangeNameAPIRequest extends BaseRequest {
  ChangeNameAPIRequest({required this.firstName, required this.lastName});
  final String firstName;
  final String lastName;
  @override
  String get endPoint => '${ApiEndpoint.auth(AuthEndpoint.CHANGE_NAME)}/$firstName/$lastName';
  @override
  Map<String, dynamic> get body => {};

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.PUT;
}