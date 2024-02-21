

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';




class ClassCancelApprovalRepository{
  Future<BaseResponse> classCancelApprovalRepository( String id,String status) async {
    try {
      return await BackendService.post(
          CancelClassApprovalAPIRequest(id: id,status:status ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class CancelClassApprovalAPIRequest extends BaseRequest {
  CancelClassApprovalAPIRequest({ required this.id,required this.status});
  final String id;
  final String status;


  @override
  String get endPoint => '${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$id/cancel?status=$status';
  @override
  Map<String, dynamic> get body =>{};

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}