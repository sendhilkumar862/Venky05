

import '../../../../../../../core/api_end_points.dart';
import '../../../../../../../core/backend_service.dart';
import '../../../../../../../core/base_request.dart';
import '../../../../../../../core/base_response.dart';
import '../../../../../../../core/hessah_exception.dart';
import '../../../../../../../product/constants/enums/backend_services_method_enums.dart';

class UpdateTicketRepository {
  Future<BaseResponse> updateTicket (int id, String status) async {
    try {
      return await BackendService.post(
          UpdateTicketAPIRequest(id: id, status: status));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class UpdateTicketAPIRequest extends BaseRequest {
  UpdateTicketAPIRequest({required this.id,required this.status});
  int id;
  String status;
  @override
  String get endPoint => ApiEndpoint.support( SupportEndpoint.UPDATE_TICKET_STATUS)+id.toString();
  @override
  Map<String, dynamic> get body => { 'status' : status};
  @override
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}