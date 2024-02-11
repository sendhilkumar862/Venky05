import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';

class ApproveRejectStudentsRepository {
  Future<BaseResponse> approveRejectStudent (String id,Map<String,dynamic> acceptRejectDetails) async {
    try {
      return await BackendService.post(
          ApproveRejectStudentAPIRequest(id:id,acceptRejectDetails: acceptRejectDetails,));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class ApproveRejectStudentAPIRequest extends BaseRequest {
  ApproveRejectStudentAPIRequest({required this.id, required this.acceptRejectDetails});
  final String id;
  final  Map<String, dynamic> acceptRejectDetails;

  @override
  String get endPoint => '${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$id/bookings';
  @override
  Map<String, dynamic> get body =>acceptRejectDetails;


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}