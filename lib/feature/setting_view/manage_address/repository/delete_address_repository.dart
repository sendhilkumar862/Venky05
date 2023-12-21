

import 'package:hessah/core/api_end_points.dart';
import 'package:hessah/core/backend_service.dart';
import 'package:hessah/core/base_request.dart';
import 'package:hessah/core/base_response.dart';

import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';


class DeleteAddressRepository{
  Future<BaseResponse> deleteAddressRepository(int id) async {
    try {
      return await BackendService.post(
          DeleteAddressAPIRequest(id:id));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class DeleteAddressAPIRequest extends BaseRequest {
  DeleteAddressAPIRequest({required this.id});
  final int id;

  @override
  String get endPoint => '${ApiEndpoint.auth(AuthEndpoint.USER_ADDRESS)}:addressId';
  @override
  Map<String, dynamic> get body => {'grade':[id]};

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.DELETE;
}