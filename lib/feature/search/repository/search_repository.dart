import '../../../core/api_end_points.dart';
import '../../../core/backend_service.dart';
import '../../../core/base_request.dart';
import '../../../core/base_response.dart';
import '../../../core/hessah_exception.dart';
import '../../../product/constants/enums/backend_services_method_enums.dart';

class SearchRepository{
  Future<BaseResponse>searchRepository(SchoolEndpoint schoolEndpoint, Map<String, dynamic> search) async {
    try {
      return await BackendService.post(
          SearchAPIRequest(schoolEndpoint:schoolEndpoint,bodyData: search));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class SearchAPIRequest extends BaseRequest {
  SearchAPIRequest({required this.schoolEndpoint, required this.bodyData});
  final SchoolEndpoint schoolEndpoint;
  final Map<String, dynamic> bodyData;

  @override
  String get endPoint => ApiEndpoint.school(schoolEndpoint);
  @override
  Map<String, dynamic> get body => bodyData;

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}