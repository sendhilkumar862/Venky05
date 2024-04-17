import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../../confirm_attendance/model/review_session_submit_model.dart';

class PostClassAttendanceRepository {
  Future<BaseResponse> postClassAttendance (String id,ClassAttendancePostModel classAttendancePostModel) async {  
    try {
      return await BackendService.post(
          PostClassAttendanceAPIRequest(id: id,classAttendancePostModel: classAttendancePostModel));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class PostClassAttendanceAPIRequest extends BaseRequest {
  PostClassAttendanceAPIRequest({required this.id,required this.classAttendancePostModel});
  final String id;
  final ClassAttendancePostModel classAttendancePostModel;
  @override
  String get endPoint => '${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$id${ApiEndpoint.school(SchoolEndpoint.ATTENDANCE)}';
  @override
  Map<String, dynamic> get body =>classAttendancePostModel.toJson();


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}