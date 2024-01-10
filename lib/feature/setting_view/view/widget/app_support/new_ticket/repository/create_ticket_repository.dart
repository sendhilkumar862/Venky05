

import '../../../../../../../core/api_end_points.dart';
import '../../../../../../../core/backend_service.dart';
import '../../../../../../../core/base_request.dart';
import '../../../../../../../core/base_response.dart';
import '../../../../../../../core/hessah_exception.dart';
import '../../../../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/create_ticket_request_model.dart';

class CreateTicketRepository {
  Future<BaseResponse> updateCountry (CreateTicketRequestModel createTicketBody) async {
    try {
      return await BackendService.post(
          CreateTicketAPIRequest(createTicketBody: createTicketBody));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class CreateTicketAPIRequest extends BaseRequest {
  CreateTicketAPIRequest({required this.createTicketBody});
  CreateTicketRequestModel createTicketBody;

  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.PERSONAL_INFO);
  @override
  Map<String, dynamic> get body => createTicketBody.toJson();


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.PUT;
}