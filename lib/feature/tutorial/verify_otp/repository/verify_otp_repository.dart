

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model_request/verify_otp_request_model.dart';


class VerifyOTPRepository {
  Future<BaseResponse> verifyOTPSend(
      {required VerifyOTPRequestModel verifyOTPRequestModel, required bool isMobile}) async {
    try {
      return await BackendService.post(
          VerifyOTPAPIRequest(verifyOTPRequestModel: verifyOTPRequestModel,isMobile:isMobile ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class VerifyOTPAPIRequest extends BaseRequest {
  VerifyOTPAPIRequest({required this.verifyOTPRequestModel,required this.isMobile});
  final VerifyOTPRequestModel verifyOTPRequestModel;
  final bool isMobile;


  @override
  String get endPoint => ApiEndpoint.auth(isMobile?AuthEndpoint.VERIFY_MOBILE_OTP:AuthEndpoint.VERIFY_EMAIL_OTP);
  @override
  Map<String, dynamic> get body => verifyOTPRequestModel.toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}