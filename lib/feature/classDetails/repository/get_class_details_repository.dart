import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';

class GetClassDetailRepository {
  Future<BaseResponse> getClassDetail () async {
    try {
      return await BackendService.post(
          ClassDetailAPIRequest());
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class ClassDetailAPIRequest extends BaseRequest {
  ClassDetailAPIRequest();

  @override
  String get endPoint => '4037c31f-7fcf-11ee-89b6-52af172c937c${ApiEndpoint.school(SchoolEndpoint.CLASS_TYPE)}';
  @override
  Map<String, dynamic> get body =>{};


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.GET;
}