

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/create_proposal_request_model.dart';




class UpdateProposalRepository{
  Future<BaseResponse> updateClassRepository( CreateProposalRequestModel createProposalRequestModel,String id, String classId) async {
    try {
      return await BackendService.post(
         UpdateClassAPIRequest(createProposalRequestModel:createProposalRequestModel,id: id, classId:  classId));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class UpdateClassAPIRequest extends BaseRequest {
  UpdateClassAPIRequest({required this.createProposalRequestModel, required this.id, required this.classId});
  final CreateProposalRequestModel createProposalRequestModel;
  final String id;
  final String classId;


  @override
  String get endPoint =>'${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$id/proposals/$classId';
  @override
  Map<String, dynamic> get body => createProposalRequestModel.toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.PUT;
}