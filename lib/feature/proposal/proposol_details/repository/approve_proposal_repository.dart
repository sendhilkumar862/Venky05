import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';

class ApproveProposalRepository {
  Future<BaseResponse> approveProposal (String id,String classId) async {
    try {
      return await BackendService.post(
          ApproveProposalAPIRequest(id: id, classId:classId));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class ApproveProposalAPIRequest extends BaseRequest {
ApproveProposalAPIRequest({required this.id, required this.classId});
  final String id;
  final String classId;
  @override
  String get endPoint => '${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$classId/proposals/$id/accept';
  @override
  Map<String, dynamic> get body =>{};


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}