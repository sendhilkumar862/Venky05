

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';




class RescheduleClassRepository{
  Future<BaseResponse> rescheduleClassRepository( String id, Map<String, dynamic>? bodyData) async {
    try {
      return await BackendService.post(
          RescheduleClassAPIRequest(bodyData:bodyData??{},id: id ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class RescheduleClassAPIRequest extends BaseRequest {
  RescheduleClassAPIRequest({required this.bodyData, required this.id});
  final String id;
  final Map<String, dynamic> bodyData;

  @override
  String get endPoint =>  '${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$id/reschedule';
  @override
  Map<String, dynamic> get body =>bodyData;

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}