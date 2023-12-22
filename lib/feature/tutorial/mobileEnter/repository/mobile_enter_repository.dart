
import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../requestModel/mobile_enter_request.dart';



class MobileEnterRepository {
  Future<BaseResponse> sign(
      {required String userId, required int countryCode, required int mobileNumber}) async {
    try {
      return await BackendService.post(
          MobileEnterAPIRequest(userId: userId, countryCode: countryCode, mobileNumber: mobileNumber));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class MobileEnterAPIRequest extends BaseRequest {
  MobileEnterAPIRequest({required this.userId, required this.countryCode,required this.mobileNumber});
  final String userId;
  final int countryCode;
  final int mobileNumber;

  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.CHANGE_NUMBER);
  @override
  Map<String, dynamic> get body => MobileEnterRequest(userId:userId, countryCode:countryCode , mobile: mobileNumber ).toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}

