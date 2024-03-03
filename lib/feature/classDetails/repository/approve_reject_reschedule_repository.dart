

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';




class ClassRejectApproveRescheduledRepository{
  Future<BaseResponse> classCancelApprovalRepository( String id,String status) async {
    try {
      return await BackendService.post(
          RejectApproveRescheduledAPIRequest(id: id,status:status ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class RejectApproveRescheduledAPIRequest extends BaseRequest {
  RejectApproveRescheduledAPIRequest({ required this.id,required this.status});
  final String id;
  final String status;


  @override
  String get endPoint => '${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$id/schedule?status=$status';
  @override
  Map<String, dynamic> get body =>{};

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}