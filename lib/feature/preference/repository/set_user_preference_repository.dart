

import 'package:hessah/core/api_end_points.dart';
import 'package:hessah/core/backend_service.dart';
import 'package:hessah/core/base_request.dart';
import 'package:hessah/core/base_response.dart';

import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/preference_request.dart';


class SetUserPreferenceRepository{
  Future<BaseResponse> setUserPreferenceRepository( PreferenceRequest preferenceRequest) async {
    try {
      return await BackendService.post(
          SetUserPreferenceAPIRequest(preferenceRequest:preferenceRequest ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class SetUserPreferenceAPIRequest extends BaseRequest {
  final PreferenceRequest preferenceRequest;
  SetUserPreferenceAPIRequest({required this.preferenceRequest});

  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.PREFERENCE);
  @override
  Map<String, dynamic> get body => preferenceRequest.toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}