
import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/personal_info_request_model.dart';
class PersonalUpdateRepository {
  Future<BaseResponse> updateCountry (PersonalInfoRequest personalInfoRequest) async {
    try {
      return await BackendService.post(
          UpdatePersonalAPIRequest(personalInfoRequest: personalInfoRequest));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class UpdatePersonalAPIRequest extends BaseRequest {
  UpdatePersonalAPIRequest({required this.personalInfoRequest});
  PersonalInfoRequest personalInfoRequest;

  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.PERSONAL_INFO);
  @override
  Map<String, dynamic> get body => personalInfoRequest.toJson();


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.PUT;
}