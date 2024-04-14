import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';

class GetReviewClassDetailRepository {
  Future<BaseResponse> getReviewSessionClassDetail (String id) async {  
    try {
      print("check class name::: home ${ReviewSessionClassDetailAPIRequest(id: id).endPoint} ${ReviewSessionClassDetailAPIRequest(id: id).header}");
      return await BackendService.post(
          ReviewSessionClassDetailAPIRequest(id: id));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class ReviewSessionClassDetailAPIRequest extends BaseRequest {
  ReviewSessionClassDetailAPIRequest({required this.id});
  final String id;

  @override
  String get endPoint => '${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$id${ApiEndpoint.school(SchoolEndpoint.REVIEW)}';
  @override
  Map<String, dynamic> get body =>{};


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.GET;
}