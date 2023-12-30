import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/email_enter_request.dart';

class RegisterMailRepositoryRepository {
  Future<BaseResponse> registerMail(
      {required EmailEnterRequest emailEnterModel}) async {
    try {
      return await BackendService.post(
          RegisterMailAPIRequest(emailEnterModel: emailEnterModel, ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class RegisterMailAPIRequest extends BaseRequest {
  RegisterMailAPIRequest({required this.emailEnterModel, });
  final EmailEnterRequest emailEnterModel;
  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.REGISTER_EMAIL);
  @override
  Map<String, dynamic> get body => emailEnterModel.toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}