import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';

class GetClassAttendanceRepository {
  Future<BaseResponse> getGetClassAttendance (String id) async {  
    try {
      print("check class name::: home ${GetClassAttendanceAPIRequest(id: id).endPoint} ${GetClassAttendanceAPIRequest(id: id).header}");
      return await BackendService.post(
          GetClassAttendanceAPIRequest(id: id));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class GetClassAttendanceAPIRequest extends BaseRequest {
  GetClassAttendanceAPIRequest({required this.id});
  final String id;

  @override
  String get endPoint => '${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$id${ApiEndpoint.school(SchoolEndpoint.ATTENDANCE)}';
  @override
  Map<String, dynamic> get body =>{};


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.GET;
}