
import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/finance_info_update_model_request.dart';


class FinanceInfoUpdateRepository {
  Future<BaseResponse> financeInfoUpdateRepository (FinanceInfoUpdateRequest financeInfoRequest) async {
    try {
      return await BackendService.post(
          UpdateFinanceInfoAPIRequest(financeInfoRequest: financeInfoRequest));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class UpdateFinanceInfoAPIRequest extends BaseRequest {
  UpdateFinanceInfoAPIRequest({required this.financeInfoRequest});
  FinanceInfoUpdateRequest financeInfoRequest;

  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.FINANCE_INFO);
  @override
  Map<String, dynamic> get body => financeInfoRequest.toJson();


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}