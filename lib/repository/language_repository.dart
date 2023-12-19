
import '../core/api_end_points.dart';
import '../core/backend_service.dart';
import '../core/base_request.dart';
import '../core/base_response.dart';
import '../core/hessah_exception.dart';
import '../product/constants/enums/backend_services_method_enums.dart';
class LanguageRepository {
  Future<BaseResponse> getCountryID () async {
    try {
      return await BackendService.post(
          GetCountryIDAPIRequest());
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class GetCountryIDAPIRequest extends BaseRequest {
  GetCountryIDAPIRequest();

  @override
  String get endPoint => ApiEndpoint.country(Public.COUNTRY_ID);
  @override
  Map<String, dynamic> get body => {};


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.GET;
}