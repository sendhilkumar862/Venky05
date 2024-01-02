
import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
class GetCityRepository {
  Future<BaseResponse> getCity () async {
    try {
      return await BackendService.post(
          GetCityAPIRequest());
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class GetCityAPIRequest extends BaseRequest {
  GetCityAPIRequest();

  @override
  String get endPoint => ApiEndpoint.country(Public.CITIES);
  @override
  Map<String, dynamic> get body => {};


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.GET;
}