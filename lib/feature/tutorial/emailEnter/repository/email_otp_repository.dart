import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';


class SendOTPRepositoryRepository {
  Future<BaseResponse> sendOTP(
      {required String id}) async {
    try {
      return await BackendService.post(
          SendOTPAPIRequest(id: id, ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class SendOTPAPIRequest extends BaseRequest {
  SendOTPAPIRequest({required this.id, });
  final String id;
  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.EMAIL_OTP);
  @override
  Map<String, dynamic> get body => {
    'userId': id,
  };

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}