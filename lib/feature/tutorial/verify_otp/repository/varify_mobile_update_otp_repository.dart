

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model_request/verify_mobile_update_otp_request_model.dart';


class VerifyMobileUpdateOTPRepository {
  Future<BaseResponse> verifyMobileUpdateOTPSend(
      {required VerifyMobileUpdateOTPRequestModel verifyMobileUpdateOTPRequestModel}) async {
    try {
      return await BackendService.post(
          VerifyMobileUpdateOTPAPIRequest(verifyMobileUpdateOTPRequestModel: verifyMobileUpdateOTPRequestModel));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class VerifyMobileUpdateOTPAPIRequest extends BaseRequest {
  VerifyMobileUpdateOTPAPIRequest({required this.verifyMobileUpdateOTPRequestModel});
  final VerifyMobileUpdateOTPRequestModel verifyMobileUpdateOTPRequestModel;


  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.VERIFY_MOBILE_OTP);
  @override
  Map<String, dynamic> get body => verifyMobileUpdateOTPRequestModel.toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}