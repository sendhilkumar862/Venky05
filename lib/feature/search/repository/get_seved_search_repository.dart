import '../../../core/api_end_points.dart';
import '../../../core/backend_service.dart';
import '../../../core/base_request.dart';
import '../../../core/base_response.dart';
import '../../../core/hessah_exception.dart';
import '../../../product/constants/enums/backend_services_method_enums.dart';

class GetSavedSearchRepository{
  Future<BaseResponse> getSavedSearchRepository(SchoolEndpoint schoolEndpoint) async {
    try {
      return await BackendService.post(
          GetSavedSearchAPIRequest(schoolEndpoint:schoolEndpoint));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class GetSavedSearchAPIRequest extends BaseRequest {
  GetSavedSearchAPIRequest({required this.schoolEndpoint});
  final SchoolEndpoint schoolEndpoint;

  @override
  String get endPoint => ApiEndpoint.school(schoolEndpoint);
  @override
  Map<String, dynamic> get body => {};

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.GET;
}