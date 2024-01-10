import 'package:hessah/core/api_end_points.dart';
import 'package:hessah/core/backend_service.dart';
import 'package:hessah/core/base_request.dart';
import 'package:hessah/core/base_response.dart';

import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../Model/get_tickets_request_model.dart';


class GetTicketsRepository{
  Future<BaseResponse> getTickets(
      GetTicketsRequestModel tickets) async {
    try {
      return await BackendService.post(
          GetTicketsAPIRequest(tickets:tickets));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class GetTicketsAPIRequest extends BaseRequest {
  GetTicketsAPIRequest({required this.tickets});
  final GetTicketsRequestModel tickets;
  @override
  String get endPoint => ApiEndpoint.support(SupportEndpoint.GET_TICKETS);
  @override
  Map<String, dynamic> get body => tickets.toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}