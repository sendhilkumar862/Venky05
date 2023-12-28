
import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/experience_info_model_request.dart';

class ExperienceInfoUpdateRepository {
  Future<BaseResponse> updateExperienceInfo (ExperienceInfoUpdateRequest experienceInfoRequest) async {
    try {
      return await BackendService.post(
          UpdateExperienceInfoAPIRequest(experienceInfoRequest: experienceInfoRequest));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class UpdateExperienceInfoAPIRequest extends BaseRequest {
  UpdateExperienceInfoAPIRequest({required this.experienceInfoRequest});
  ExperienceInfoUpdateRequest experienceInfoRequest;

  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.EXPERIENCE_INFO);
  @override
  Map<String, dynamic> get body => experienceInfoRequest.toJson();


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.PUT;
}