import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../../rating/model/review_session_submit_model.dart';

class PostReviewClassDetailRepository {
  Future<BaseResponse> postReviewSessionClassDetail (String id,ReviewSessionSubmitModal reviewSessionSubmitModal) async {  
    try {

      return await BackendService.post(
          ReviewSessionClassDetailAPIRequest(id: id, reviewSessionSubmitModal: reviewSessionSubmitModal));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class ReviewSessionClassDetailAPIRequest extends BaseRequest {
  ReviewSessionClassDetailAPIRequest({required this.id,required this.reviewSessionSubmitModal});
  final String id;
  final ReviewSessionSubmitModal reviewSessionSubmitModal;
  @override
  String get endPoint => '${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$id${ApiEndpoint.school(SchoolEndpoint.REVIEW)}';
  @override
  Map<String, dynamic> get body =>reviewSessionSubmitModal.toJson();


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}