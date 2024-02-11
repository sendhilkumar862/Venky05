

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';




class MakePaymentRepository{
  Future<BaseResponse>   makePaymentRepository( String id,String paymentId) async {
    try {
      return await BackendService.post(
          MakePaymentAPIRequest(classId: id,paymentId: paymentId ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class  MakePaymentAPIRequest extends BaseRequest {
  MakePaymentAPIRequest({ required this.classId,required this.paymentId});
  final String classId;
  final String paymentId;
  @override
  String get endPoint => '${ApiEndpoint.users(UsersEndPoint.MAKE_PAYMENT)}$classId/payment/$paymentId';
  @override
  Map<String, dynamic> get body =>{};

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}