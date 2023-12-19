import '../Request/sign_in_request.dart';
import '../core/api_end_points.dart';
import '../core/backend_service.dart';
import '../core/base_request.dart';
import '../core/base_response.dart';
import '../core/hessah_exception.dart';
import '../product/constants/enums/backend_services_method_enums.dart';

class ProfileSetRepository {
  Future<BaseResponse> profileSet() async {
    try {
      return await BackendService.post(
          ProfileSetRequest());
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class ProfileSetRequest extends BaseRequest {
  ProfileSetRequest();

  @override
  String get endPoint => ApiEndpoint.profileSet;
  @override
  Map<String, dynamic> get body => {};

  @override
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.GET;
}