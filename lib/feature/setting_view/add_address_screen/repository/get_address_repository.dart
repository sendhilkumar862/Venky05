

import 'package:hessah/core/api_end_points.dart';
import 'package:hessah/core/backend_service.dart';
import 'package:hessah/core/base_request.dart';
import 'package:hessah/core/base_response.dart';

import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';


class GetAddressRepository{
  Future<BaseResponse> getAddressRepository() async {
    try {
      return await BackendService.post(
          GetAddressAPIRequest());
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class GetAddressAPIRequest extends BaseRequest {
  GetAddressAPIRequest();

  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.USER_ADDRESS);
  @override
  Map<String, dynamic> get body => {};

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.GET;
}