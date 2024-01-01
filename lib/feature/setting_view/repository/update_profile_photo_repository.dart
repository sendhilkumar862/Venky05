import '../../../core/api_end_points.dart';
import '../../../core/backend_service.dart';
import '../../../core/base_request.dart';
import '../../../core/base_response.dart';
import '../../../core/hessah_exception.dart';
import '../../../product/constants/enums/backend_services_method_enums.dart';

class UpdateProfilePhotoRepository {
  Future<BaseResponse> updateProfilePhoto(String path) async {
    try {
      return await BackendService.post(UpdateProfileAPIRequest(path: path));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(
            status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(
          status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class UpdateProfileAPIRequest extends BaseRequest {
  UpdateProfileAPIRequest({required this.path});
  String path;

  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.UPLOAD_PROFILE);

  @override
  Map<String, dynamic> get body =>
      <String, String>{'path': path, 'fileName': path.split('/').last};

  @override
  BackEndServicesEnum get apiMethod => BackEndServicesEnum.PHOTO;
}
