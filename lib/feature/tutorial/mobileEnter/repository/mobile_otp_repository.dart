import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../requestModel/mobile_enter_request.dart';



class MobileOTPSendRepository {
  Future<BaseResponse> mobileOTPSend(
      {required MobileEnterRequest mobileEnterRequest}) async {
    try {
      return await BackendService.post(
          MobileOTPAPIRequest(mobileEnterRequest: mobileEnterRequest));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class MobileOTPAPIRequest extends BaseRequest {
  MobileOTPAPIRequest({required this.mobileEnterRequest});
  final MobileEnterRequest mobileEnterRequest;


  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.MOBILE_OTP);
  @override
  Map<String, dynamic> get body => mobileEnterRequest.toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}

