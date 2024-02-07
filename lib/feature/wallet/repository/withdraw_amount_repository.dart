import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';

class WithdrawAmountRepository {
  Future<BaseResponse> withdrawAmount (int amount,String requestType) async {
    try {
      return await BackendService.post(
          WithdrawAmountAPIRequest(amount: amount, requestType:requestType));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class WithdrawAmountAPIRequest extends BaseRequest {
  WithdrawAmountAPIRequest({required this.amount, required this.requestType});
  final int amount;
  final String requestType;
  @override
  String get endPoint => requestType=='add'?ApiEndpoint.users(UsersEndPoint.ADD_AMOUNT):ApiEndpoint.users(UsersEndPoint.WITHDRAW_AMOUNT);
  @override
  Map<String, dynamic> get body =>{'amount':amount};


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}