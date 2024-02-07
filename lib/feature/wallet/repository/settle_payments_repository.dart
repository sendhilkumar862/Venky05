import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';

class SettlePaymentsRepository {
  Future<BaseResponse> settlePayment (int amount) async {
    try {
      return await BackendService.post(
          SettlePaymentAPIRequest(amount: amount));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class SettlePaymentAPIRequest extends BaseRequest {
  SettlePaymentAPIRequest({required this.amount});
  final int amount;
  @override
  String get endPoint => ApiEndpoint.users(UsersEndPoint.SETTLE_PAYMENT);
  @override
  Map<String, dynamic> get body =>{'amount':amount};


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}