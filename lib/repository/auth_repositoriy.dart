import '../Request/sign_in_request.dart';
import '../core/api_end_points.dart';
import '../core/backend_service.dart';
import '../core/base_request.dart';
import '../core/base_response.dart';
import '../core/hessah_exception.dart';
import '../product/constants/enums/backend_services_method_enums.dart';

class AuthRepositoryRepository {
  Future<BaseResponse> sign(
      {required String email, required String password}) async {
    try {
      return await BackendService.post(
          SignInAPIRequest(email: email, password: password));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class SignInAPIRequest extends BaseRequest {
  SignInAPIRequest({required this.email, required this.password});
  final String email;
  final String password;
  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.LOGIN);
  @override
  Map<String, dynamic> get body => SingInRequest(email:email, password:   password ).toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.Post;
}