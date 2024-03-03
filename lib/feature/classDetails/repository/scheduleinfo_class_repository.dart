

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';




class ScheduleInfoClassRepository{
  Future<BaseResponse> scheduleInfoClassRepository( String id) async {
    try {
      return await BackendService.post(
          ScheduleClassAPIRequest(id: id ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class ScheduleClassAPIRequest extends BaseRequest {
  ScheduleClassAPIRequest({required this.id});
  final String id;


  @override
  String get endPoint =>  '${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$id/scheduleInfo';
  @override
  Map<String, dynamic> get body =>{};

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.GET;
}