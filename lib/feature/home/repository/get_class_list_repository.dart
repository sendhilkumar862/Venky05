import 'package:hessah/feature/home/model/get_class_list_request_model.dart';

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';

class GetClassListRepository {
  Future<BaseResponse> getClassList (GetClassRequestModel getClassRequestModel) async {
    try {
      return await BackendService.post(
          ClassListAPIRequest(getClassRequestModel: getClassRequestModel));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class ClassListAPIRequest extends BaseRequest {
  ClassListAPIRequest({required this.getClassRequestModel});
  final GetClassRequestModel getClassRequestModel;
  @override
  String get endPoint => ApiEndpoint.school(SchoolEndpoint.GET);
  @override
  Map<String, dynamic> get body => getClassRequestModel.toJson();


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}