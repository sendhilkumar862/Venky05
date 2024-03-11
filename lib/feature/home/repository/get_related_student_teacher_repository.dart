

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/get_class_list_request_model.dart';



class GetRelatedStudentTeacherListRepository {
  Future<BaseResponse> getRelatedList (GetClassRequestModel getRelatedRequestModel) async {
    try {
      return await BackendService.post(
          RelatedListAPIRequest(getRelatedRequestModel: getRelatedRequestModel));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class RelatedListAPIRequest extends BaseRequest {
  RelatedListAPIRequest({required this.getRelatedRequestModel});
  final GetClassRequestModel getRelatedRequestModel;

  @override
  String get endPoint => ApiEndpoint.favourites(FavouritesEndPoint.Related);
  @override
  Map<String, dynamic> get body => getRelatedRequestModel.toJson();


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}