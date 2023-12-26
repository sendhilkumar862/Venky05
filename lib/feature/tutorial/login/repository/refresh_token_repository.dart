

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';

class RefreshTokenRepositoryRepository {
  Future<BaseResponse> refreshToken() async {
    try {
      return await BackendService.post(
          RefreshTokenAPIRequest());
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class RefreshTokenAPIRequest extends BaseRequest {
  RefreshTokenAPIRequest();
  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.REFRESH_TOKEN);
  @override
  Map<String, dynamic> get body => {};

  @override
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}