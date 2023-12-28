
import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/teacher_info_update_model_request.dart';

class TeachingInfoUpdateRepository {
  Future<BaseResponse> updateTeachingInfo (TeacherInfoUpdateRequest personalInfoRequest) async {
    try {
      return await BackendService.post(
          UpdateTeachingInfoAPIRequest(teachingInfoRequest: personalInfoRequest));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class UpdateTeachingInfoAPIRequest extends BaseRequest {
  UpdateTeachingInfoAPIRequest({required this.teachingInfoRequest});
  TeacherInfoUpdateRequest teachingInfoRequest;

  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.TEACHING_INFO);
  @override
  Map<String, dynamic> get body => teachingInfoRequest.toJson();


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.PUT;
}