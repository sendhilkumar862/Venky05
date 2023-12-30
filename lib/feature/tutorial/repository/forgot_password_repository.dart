

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';


class ForgotPasswordRepository {
  Future<BaseResponse> forgotPassword(
      {required String email}) async {
    try {
      return await BackendService.post(
          ForgotPasswordAPIRequest(email: email ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class ForgotPasswordAPIRequest extends BaseRequest {
  ForgotPasswordAPIRequest({required this.email});
  final String email;



  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.RESET_PASSWORD);
  @override
  Map<String, dynamic> get body => { 'email': email};

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}