

import '../../../../../../../core/api_end_points.dart';
import '../../../../../../../core/backend_service.dart';
import '../../../../../../../core/base_request.dart';
import '../../../../../../../core/base_response.dart';
import '../../../../../../../core/hessah_exception.dart';
import '../../../../../../../product/constants/enums/backend_services_method_enums.dart';

class ChatReplyTicketRepository {
  Future<BaseResponse> chatReplyTicket (int id) async {
    try {
      return await BackendService.post(
          ChatReplyTicketAPIRequest(id: id));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class ChatReplyTicketAPIRequest extends BaseRequest {
  ChatReplyTicketAPIRequest({required this.id});
  int id;
  @override
  String get endPoint => ApiEndpoint.support( SupportEndpoint.UPDATE_TICKET_STATUS)+id.toString();
  @override
  Map<String, dynamic> get body => {};
  @override
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}