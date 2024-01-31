import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';

class GetProposalAllRepository {
  Future<BaseResponse> getProposalAll (String id, int startIndex) async {
    try {
      return await BackendService.post(
          ClassProposalAPIRequest(id: id,startIndex: startIndex));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class ClassProposalAPIRequest extends BaseRequest {
  ClassProposalAPIRequest({required this.id,required this.startIndex});
  final String id;
  final int startIndex;

  @override
  String get endPoint => '${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$id/proposals?limit=10&startIndex=$startIndex';
  @override
  Map<String, dynamic> get body =>{};


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.GET;
}