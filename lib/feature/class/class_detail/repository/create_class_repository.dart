

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/create_class_request_model.dart';



class CreateClassRepository{
  Future<BaseResponse> createClassRepository( CreateClassRequestModel createClassRequestModel) async {
    try {
      return await BackendService.post(
          CreateClassAPIRequest(createClassRequestModel:createClassRequestModel ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class CreateClassAPIRequest extends BaseRequest {
  CreateClassAPIRequest({required this.createClassRequestModel});
  final CreateClassRequestModel createClassRequestModel;

  @override
  String get endPoint => ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS);
  @override
  Map<String, dynamic> get body => createClassRequestModel.toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}