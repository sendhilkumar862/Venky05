import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/password_model_request.dart';

class PasswordRepository {
  Future<BaseResponse> register(
      {required RegisterRequest registerRequest}) async {
    try {
      return await BackendService.post(
          SignInAPIRequest(registerRequest:registerRequest));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class SignInAPIRequest extends BaseRequest {
  SignInAPIRequest({required this.registerRequest });
  final RegisterRequest registerRequest;



  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.REGISTER);
  @override
  Map<String, dynamic> get body => registerRequest.toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}