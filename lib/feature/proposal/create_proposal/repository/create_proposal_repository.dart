

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/create_proposal_request_model.dart';




class CreateProposalRepository{
  Future<BaseResponse> createClassRepository( CreateProposalRequestModel createProposalRequestModel,String id) async {
    try {
      return await BackendService.post(
          CreateClassAPIRequest(createProposalRequestModel:createProposalRequestModel,id: id ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class CreateClassAPIRequest extends BaseRequest {
  CreateClassAPIRequest({required this.createProposalRequestModel, required this.id});
  final CreateProposalRequestModel createProposalRequestModel;
  final String id;

  @override
  String get endPoint => '${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$id/proposals';
  @override
  Map<String, dynamic> get body => createProposalRequestModel.toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}