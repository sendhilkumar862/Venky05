

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';


class ResendOTPRepository {
  Future<BaseResponse> resendOTPSend(
      {required Map<String, dynamic> bodyData}) async {
    try {
      return await BackendService.post(
          ResendOTPAPIRequest(bodyData: bodyData ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class ResendOTPAPIRequest extends BaseRequest {
  ResendOTPAPIRequest({required this.bodyData});
  final Map<String, dynamic> bodyData;



  @override
  String get endPoint => ApiEndpoint.auth(bodyData.length>1?AuthEndpoint.MOBILE_OTP:AuthEndpoint.EMAIL_OTP);
  @override
  Map<String, dynamic> get body => bodyData;

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}