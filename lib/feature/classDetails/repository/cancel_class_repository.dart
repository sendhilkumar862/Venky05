

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';




class CancelClassRepository{
  Future<BaseResponse> cancelClassRepositoryRepository( String id) async {
    try {
      return await BackendService.post(
          CancelClassAPIRequest(id: id ));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class CancelClassAPIRequest extends BaseRequest {
  CancelClassAPIRequest({ required this.id});
  final String id;


  @override
  String get endPoint => '${ApiEndpoint.school(SchoolEndpoint.CREATE_CLASS)}/$id/cancel';
  @override
  Map<String, dynamic> get body =>{};

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.DELETE;
}