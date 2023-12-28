
import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
class HelpersRepository {
  Future<BaseResponse> getHelpers (SchoolEndpoint schoolEndpoint) async {
    try {
      return await BackendService.post(
          HelpersAPIRequest(schoolEndpoint:schoolEndpoint));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class HelpersAPIRequest extends BaseRequest {
  final SchoolEndpoint schoolEndpoint;
  HelpersAPIRequest({required this.schoolEndpoint});

  @override
  String get endPoint => ApiEndpoint.school(schoolEndpoint);
  @override
  Map<String, dynamic> get body =>{};


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.GET;
}