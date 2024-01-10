


import '../../../../../../../core/api_end_points.dart';
import '../../../../../../../core/backend_service.dart';
import '../../../../../../../core/base_request.dart';
import '../../../../../../../core/base_response.dart';
import '../../../../../../../core/hessah_exception.dart';
import '../../../../../../../product/constants/enums/backend_services_method_enums.dart';

class GetMasterDataAppSupportRepository {
  Future<BaseResponse> getMasterDataAppSupport () async {
    try {
      return await BackendService.post(
          MasterDataAppSupportAPIRequest());
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class MasterDataAppSupportAPIRequest extends BaseRequest {
  MasterDataAppSupportAPIRequest();

  @override
  String get endPoint => ApiEndpoint.support(SupportEndpoint.MASTER_DATA);
  @override
  Map<String, dynamic> get body =>{};
  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.GET;
}