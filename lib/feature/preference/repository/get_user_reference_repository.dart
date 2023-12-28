

import 'package:hessah/core/api_end_points.dart';
import 'package:hessah/core/backend_service.dart';
import 'package:hessah/core/base_request.dart';
import 'package:hessah/core/base_response.dart';

import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';


class GetUserPreferenceRepository{
  Future<BaseResponse> getUserPreferenceRepository() async {
    try {
      return await BackendService.post(
          GetUserPreferenceAPIRequest());
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class GetUserPreferenceAPIRequest extends BaseRequest {
  GetUserPreferenceAPIRequest();

  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.PREFERENCE);
  @override
  Map<String, dynamic> get body => {};

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.GET;
}