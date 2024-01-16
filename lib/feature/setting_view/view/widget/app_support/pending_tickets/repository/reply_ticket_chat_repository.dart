

import '../../../../../../../core/api_end_points.dart';
import '../../../../../../../core/backend_service.dart';
import '../../../../../../../core/base_request.dart';
import '../../../../../../../core/base_response.dart';
import '../../../../../../../core/hessah_exception.dart';
import '../../../../../../../product/constants/enums/backend_services_method_enums.dart';
import '../../new_ticket/model/create_ticket_request_model.dart';
import '../model/reply_ticket_rquest_model.dart';

class ReplyTicketRepository {
  Future<BaseResponse> replyTicket (int id,   ReplyTicketRequestModel replyTicketBody) async {
    try {
      return await BackendService.post(
         ReplyTicketAPIRequest(id: id, replyTicketBody: replyTicketBody));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class ReplyTicketAPIRequest extends BaseRequest {
  ReplyTicketAPIRequest({required this.id,required this.replyTicketBody});
  int id;
  ReplyTicketRequestModel replyTicketBody;
  @override
  String get endPoint => ApiEndpoint.support( SupportEndpoint.REPLY_MESSAGE)+id.toString();
  @override
  Map<String, dynamic> get body => replyTicketBody.toJson();
  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.CUSTOM;
}