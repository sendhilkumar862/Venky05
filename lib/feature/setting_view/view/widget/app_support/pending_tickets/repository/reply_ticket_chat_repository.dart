

import '../../../../../../../core/api_end_points.dart';
import '../../../../../../../core/backend_service.dart';
import '../../../../../../../core/base_request.dart';
import '../../../../../../../core/base_response.dart';
import '../../../../../../../core/hessah_exception.dart';
import '../../../../../../../product/constants/enums/backend_services_method_enums.dart';

class ReplyTicketRepository {
  Future<BaseResponse> replyTicket (int id, String msg) async {
    try {
      return await BackendService.post(
         ReplyTicketAPIRequest(id: id, msg: msg));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class ReplyTicketAPIRequest extends BaseRequest {
  ReplyTicketAPIRequest({required this.id,required this.msg});
  int id;
  String msg;
  @override
  String get endPoint => ApiEndpoint.support( SupportEndpoint.CREATE_TICKET)+id.toString();
  @override
  Map<String, dynamic> get body => { "message" : msg};
  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}