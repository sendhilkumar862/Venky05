
import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/personal_info_request_model.dart';
class UploadDocRepository {
  Future<BaseResponse> uploadDocument (String path) async {
    try {
      return await BackendService.post(
          UploadDocAPIRequest(path: path));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class UploadDocAPIRequest extends BaseRequest {
  UploadDocAPIRequest({required this.path});
  final String path;

  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.CERTIFICATE);
  @override
  Map<String, dynamic> get body =>{
    'path':path,
    'fileName':path.split('/').last
  };


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.PHOTO;
}