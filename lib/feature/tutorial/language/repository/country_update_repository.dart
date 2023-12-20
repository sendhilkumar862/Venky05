
import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
class CountryUpdateRepository {
  Future<BaseResponse> updateCountry (String countryName) async {
    try {
      return await BackendService.post(
          UpdateCountryAPIRequest(countryName: countryName));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class UpdateCountryAPIRequest extends BaseRequest {
  UpdateCountryAPIRequest({required this.countryName});
  String countryName;

  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.UPDATE_COUNTRY)+countryName;
  @override
  Map<String, dynamic> get body => {};


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.PUT;
}